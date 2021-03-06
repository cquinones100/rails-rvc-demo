module Rvc
  class Component
    include Rvc::ComponentHelper

    class << self
      def render(base: , **args, &block)
        component = new(base: base, block: block, **args)

        render_string = component.render

        javascript_functions = component.javascript_functions.map do |func|
          func.to_script_tag
        end.join

        component.base.render inline: javascript_functions + render_string
      end

      def locals(*args, **required_args)
        define_method(:registered_locals) { args + required_args.keys }
        define_method(:locals) { args + required_args.keys }

        define_method(:required_locals) do
          required_args.each_with_object([]) do |(arg, value), acc|
            acc << arg if value == :required
          end
        end
      end
    end

    attr_reader :base

    def initialize(base: nil, block:, **args)
      @base = base || Base.new(base: self)
      @block = block

      if respond_to? :registered_locals 
        registered_locals.each do |local|
          instance_variable_set("@#{local}", args[local])
        end
      end

      unless undefined_required_locals.empty?
        raise RequiredLocalNotDefined.new(
          base: self,
          undefined_required_locals: undefined_required_locals
        )
      end
    end

    def javascript_functions
      @javascript_functions ||= []
    end

    private

    def JavascriptFunction(name: nil, **arguments, &block)
      javascript_function = Rvc::JavascriptFunction.new block: block,
        arguments: arguments,
        name: name

      javascript_functions << javascript_function

      javascript_function
    end

    def html
      base.render inline: yield
    end

    def inline
      inline = yield Rvc::Inline.new(base: base)

      base.render inline: inline.render
    end

    def undefined_required_locals
      return [] unless respond_to? :required_locals

      required_locals.find_all do |local|
        instance_variable_get("@#{local}").nil?
      end
    end

    private

    attr_reader :block
  end
end

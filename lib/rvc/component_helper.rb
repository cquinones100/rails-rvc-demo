module ComponentHelper
  class ComponentError < StandardError; end

  COMPONENT_PATH = './app/components'.freeze

  COMPONENT_PATHS = Dir["#{COMPONENT_PATH}/**/*.rb"]

  COMPONENT_PATHS.each do |path|
    name = path.split('/').last.gsub('.rb', '').camelcase

    define_method(name) do |rerender: false, **arguments, &block|
      base = self.class < Component || Component === self ? @base : self

      klass = name.constantize

      if rerender
        klass.new(
          base: base,
          **arguments,
          rerender: rerender,
          block: block
        ).js_rerender
      else
        klass.render(base: base, block: block, **arguments)
      end
    end
  end

  def JavascriptFunction(name: nil, **arguments, &block)
    JavascriptFunction.new(block: block, arguments: arguments, name: name)
  end

  extend self
end


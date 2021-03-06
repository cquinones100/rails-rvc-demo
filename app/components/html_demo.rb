class HtmlDemo < Rvc::Component
  TITLE = 'HTML'.freeze
  SUMMARY = 'Generate HTML with Ruby Objects'.freeze

  def render
    FeatureDemo title: TITLE, summary: SUMMARY, embed_code: embed_code do
        Div id: 'a-div', style: 'border: solid 1px;width:100%padding:5px;' do
          inline do |container|
            container.add do
              Div id: 'a-second-div',
                class: 'some-class',
                style: 'border: dotted 1px;width:50%;float:left' do
                'left'
              end
            end

            container.add do
              Div id: 'a-third-div',
                class: 'third-div-class',
                style: 'border: dotted 1px;width:50%;float:left' do
                'right'
              end
            end
          end
        end
      end
  end

  def embed_code
    <<~HTML
    <script src="https://gist.github.com/cquinones100/95c648162d2052dd4d8c7b1d4f365a04.js"></script>
    HTML
  end
end

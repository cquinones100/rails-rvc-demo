class Home < Component
  def render
    body
  end

  def body
    Div id: 'container', class: 'container' do
      inline do |container|
        container.add do
          Div class: 'row' do
            inline do |title_row_container|
              title_row_container.add do
                Div class: 'col-md-8 pull-right' do
                  <<~HTML
                  <h1>RVC (Ruby View Components)</h1>
                  HTML
                end
              end

              title_row_container.add do
                Div class: 'col-md-4' do
                  <<~HTML
                  <a href='https://github.com/cquinones100/rvc_compiler'>
                    View on Github
                  </a>
                  HTML
                end
              end
            end
          end
        end

        container.add do
          Div id: 'first-row', class: 'row' do
            Div id: 'html-demo-column', class: 'col-md-12' do
              HtmlDemo do; end
            end
          end
        end

        container.add do
          Div id: 'second-row', class: 'row' do
            Div id: 'javascript-demo-column', class: 'col-md-12' do
              JavascriptDemo do; end
            end
          end
        end

        container.add do
          Div id: 'third-row', class: 'row' do
            Div id: 'testing-demo-column', class: 'col-md-12' do
              TestingDemo do; end
            end
          end
        end
      end
    end
  end
end

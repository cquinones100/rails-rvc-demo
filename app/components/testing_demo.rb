class TestingDemo < Component
  TITLE = 'Testing'.freeze
  SUMMARY = 'Test components with expressive matchers'.freeze

  def render
    FeatureDemo title: TITLE, summary: SUMMARY, embed_code: embed_code do; end
  end

  def embed_code
    <<~HTML
    <script src="https://gist.github.com/cquinones100/282d6281ab4de662c3ec3278b43373bb.js"></script>
    HTML
  end
end

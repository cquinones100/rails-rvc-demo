class TextInput < Component
  locals :onchange

  def render
    <<~HTML
      <input onkeyup='#{@onchange}'></input>
    HTML
  end
end

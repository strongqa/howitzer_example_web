class ErrorsSection < Howitzer::Web::Section
  me :xpath, '//div[contains(@class,"alert")]'

  element :title, 'strong'
  element :details, 'li'

  def error_message
    [title_element.text, details_element.text].compact.join(' ')
  end
end

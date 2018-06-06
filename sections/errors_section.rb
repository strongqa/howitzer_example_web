class ErrorsSection < Howitzer::Web::Section
  me '*.alert'

  element :title, 'strong'
  element :details, 'li'

  def error_message
    [title_element.text, details_element.text].compact.join(' ')
  end
end

class ArticleErrorsSection < Howitzer::Web::Section
  me  'div#error_explanation'

  element :title, 'h2'
  element :details, 'ul'

  def error_message
    [title_element.text, details_element.text].compact.join(' ')
  end
end

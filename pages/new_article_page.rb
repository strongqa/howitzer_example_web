require_relative 'demo_app_page'
class NewArticlePage < DemoAppPage
  path '/articles/new/'
  section :article_errors
  validate :title, /\ADemo web application - New Article\z/

  element :article_title_field, :fillable_field, 'article[title]'
  element :article_text_field, :fillable_field, 'article[text]'
  element :create_article_button, :button, 'Create Article'
  element :alert_text, '#error_explanation'

  def fill_form(title: nil, text: nil)
    Howitzer::Log.info "Fill in Create article form with title: #{title} , and body #{text}"
    article_title_field_element.set(title) unless title.nil?
    article_text_field_element.set(text) unless text.nil?
    self
  end

  def submit_form
    Howitzer::Log.info 'Submit Create article form'
    create_article_button_element.click
    self
  end
end

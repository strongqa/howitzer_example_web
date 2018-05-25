require_relative 'demo_app_page'
class ArticlePage < DemoAppPage
  path '/articles{/id}'
  validate :title, /\ADemo web application - Article title .+\z/
  validate :url, %r{\/articles\/\d+\/?\z}

  element :comment_field, :fillable_field, 'comment_body'
  element :add_comment_button, :button, 'Create comment'
  element :commenter_name, :xpath, ".//p[contains(.,'Commenter:')]"
  element :comment_text, :xpath, ".//p[contains(.,'Comment:')]"
  element :destroy_comment, :xpath,
          ->(comment) { ".//p[contains(.,'#{comment}')]/following-sibling::p/a[.='Destroy Comment']" }
  element :article_button, :xpath, ->(title) { "//a[contains(.,'#{title}')]" }
  element :comment_form, '#new_comment'
  element :back_to_articles, :xpath, '//*[@class="breadcrumb"]//a[contains(.,"Articles")]'
  element :edit_article_button, :xpath, ".//a[contains(.,'Edit Article')]"

  def fill_comment_form(body: nil)
    Howitzer::Log.info "Fill in Add Comment form with body: #{body}"
    comment_field_element.set(body) unless body.nil?
  end

  def submit_form
    Howitzer::Log.info 'Submit Add Comment form'
    add_comment_button_element.click
  end

  def comment_data
    {
      commenter: commenter_name_element.text.gsub(/Commenter: /, ''),
      comment: comment_text_element.text.gsub(/Comment: /, '')
    }
  end

  def click_article_button(text)
    Howitzer::Log.info "Open '#{text}' article"
    article_button_element(text).click
  end

  def destroy_comment(comment_text, confirmation = true)
    Howitzer::Log.info "Destroy comment  '#{comment_text}' on article page with confirmation: '#{confirmation}'"
    destroy = -> { destroy_comment_element(comment_text).click }
    if confirmation
      accept_js_confirmation { destroy.call }
    else
      dismiss_js_confirmation { destroy.call }
    end
  end

  def back_to_article_list
    back_to_articles_element.click
  end
end

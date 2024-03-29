require_relative 'demo_app_page'
class ArticlePage < DemoAppPage
  path '/articles{/id}'
  validate :url, %r{/articles/\d+/?\z}

  element :comment_field, :fillable_field, 'comment_body'
  element :add_comment_button, :button, 'Create comment'
  element :commenter_name, :xpath, ".//p[contains(.,'Commenter:')]"
  element :comment_text, :xpath, ".//p[contains(.,'Comment:')]"

  element :comment_item, :xpath, lambda { |comment:|
    " .//p[@class='comments__body'][text()='#{comment}']/ancestor::div[@class='comments__item']"
  }
  element :destroy_comment, 'a[data-method="delete"]'
  element :article_button, :xpath, ->(title:) { ".//a[contains(.,'#{title}')]" }
  element :comment_form, '#new_comment'
  element :breadcrumb, '*.breadcrumb'
  element :breadcrumb_link, :xpath, ->(link_name:) { ".//a[contains(.,'#{link_name}')]" }
  element :edit_article_button, :link, 'Edit Article'

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
    article_button_element(lambda_args(title: text)).click
  end

  def destroy_comment(comment_text, confirmation: true)
    Howitzer::Log.info "Destroy comment  '#{comment_text}' on article page with confirmation: '#{confirmation}'"
    destroy = -> { within_comment_item_element(lambda_args(comment: comment_text)) { destroy_comment_element.click } }
    if confirmation
      accept_js_confirmation { destroy.call }
    else
      dismiss_js_confirmation { destroy.call }
    end
  end

  def back_to_article_list
    within_breadcrumb_element { breadcrumb_link_element(lambda_args(link_name: 'Articles')).click }
  end
end

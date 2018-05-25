require_relative 'demo_app_page'
class ArticleListPage < DemoAppPage
  path '/articles/'
  validate :title, /\ADemo web application - Listing Articles\z/

  element :new_article_button, :xpath, "//a[@href='/articles/new']"
  element :article_button, :xpath, ->(title) { "(//a[contains(.,'#{title}')])[1]" }
  element :destroy_button, :xpath,
          ->(title) { %(//a[@class="article__title"][text()="#{title}"]/ancestor::section/following-sibling::div[@class="admin__wrapper"][1]/a[text()="Delete"]) }
  element :edit_button, :xpath,
          ->(title) { %(//a[@class="article__title"][text()="#{title}"]/ancestor::section/following-sibling::div[@class="admin__wrapper"][1]/a[text()="Edit"]) }
  element :article_link, :link, ->(text) { text }, match: :first

  def add_new_article
    Howitzer::Log.info 'Adding new article'

    new_article_button_element.click
    NewArticlePage.given
  end

  def edit_article(title)
    Howitzer::Log.info "Edit article: '#{title}'"
    edit_button_element(title).click
  end

  def destroy_article(title, confirmation = true)
    Howitzer::Log.info "Destroy article: '#{title}' with confirmation: '#{confirmation}'"
    destroy = -> { destroy_button_element(title).click }
    if confirmation
      accept_js_confirmation { destroy.call }
    else
      dismiss_js_confirmation { destroy.call }
    end
  end

  def open_article(text)
    Howitzer::Log.info "Open '#{text}' article"
    if main_menu_section.tablet_screen?
      article_link_element(text).click
    else
      article_button_element(text).click
    end
  end
end

require_relative 'demo_app_page'
class ArticleListPage < DemoAppPage
  path '/articles/'
  validate :title, /\ADemo web application - Listing Articles\z/

  element :new_article_button, :xpath, ".//a[@href='/articles/new']"
  element :article_item, :xpath, ->(title) { ".//a[.='#{title}']/ancestor::section[@class='article__item']" }
  element :article_button, 'a.article__title'
  element :destroy_button, :xpath, ".//a[.='Delete']"
  element :edit_button, :xpath, ".//a[.='Edit']"
  element :article_link, :link, ->(text) { text }, match: :first
  element :search_input, '.sidebar__input'
  element :search_btn, '.fa-search'
  element :recent_post, :xpath, ->(name) { "//div[@class='recent-posts__desc']//a[contains(text(),'#{name}')]" }
  element :category_item, :xpath, ->(name) { "//div[@class='sidebar__item']//a[.='#{name}']" }

  def add_new_article
    Howitzer::Log.info 'Adding new article'

    new_article_button_element.click
    NewArticlePage.given
  end

  def edit_article(title)
    Howitzer::Log.info "Edit article: '#{title}'"
    within_article_item_element(title) { edit_button_element.click }
  end

  def destroy_article(title, confirmation = true)
    Howitzer::Log.info "Destroy article: '#{title}' with confirmation: '#{confirmation}'"
    destroy = -> { within_article_item_element(title) { destroy_button_element.click } }
    if confirmation
      accept_js_confirmation { destroy.call }
    else
      dismiss_js_confirmation { destroy.call }
    end
  end

  def open_article(text)
    Howitzer::Log.info "Open '#{text}' article"
    if main_menu_section.tablet_screen?
      within_article_item_element(text) { article_link_element.click }
    else
      within_article_item_element(text) { article_button_element.click }
    end
  end

  def search_article(name)
    search_input_element.set(name)
    search_btn_element.click
  end

  def open_recent_post(name)
    recent_post_element(name).click
  end

  def open_category_item(name)
    category_item_element(name).click
  end
end

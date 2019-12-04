require_relative 'demo_app_page'
require_relative 'howitzer_home_page'
class HomePage < DemoAppPage
  path '/'
  validate :title, /\ADemo web application - Home\z/
  validate :url, %r{\A(?:.*?://)?[^/]*/?\z}

  element :article_link, :xpath, ->(title) { ".//a[.='#{title}']" }
  element :article_group, :xpath, ->(number) { "(//*[@class=\"article__group_title\"])[#{number}]" }
  element :frame_howitzer, 'iframe#howitzer'
  element :quick_start_btn, '.hero__btn'
  iframe :howitzer_home, 'howitzer'

  def view_article(article_title)
    Howitzer::Log.info "Open article page byb title: '#{article_title}'"
    article_link_element(article_title).click
    ArticlePage.given
  end

  def find_article_group_text(group_number)
    article_group_element(group_number).text
  end
end

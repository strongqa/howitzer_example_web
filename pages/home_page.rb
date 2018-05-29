require_relative 'demo_app_page'
require_relative 'howitzer_home_page'
class HomePage < DemoAppPage
  path '/'
  validate :title, /\ADemo web application - Home\z/
  validate :url, %r{\A(?:.*?:\/\/)?[^\/]*\/?\z}

  element :article_link, :xpath, ->(title) { ".//a[.='#{title}']" }
  # element :panel_heading, :xpath, ->(title) { "//h3[text()=\"#{title}\"]/parent::*/following-sibling::*" }
  element :article_group, :xpath, ->(number) { "(//*[@class=\"article__group_title\"])[#{number}]" }
  element :frame_howitzer, 'iframe#howitzer'
  element :quick_start_btn, '.hero__btn'
  iframe :howitzer_home, 'howitzer'

# TODO:delete sleep
  def iframe_wait
    Capybara.current_session.find('iframe#howitzer')
    sleep 1
    within_frame('howitzer') do
      # binding.pry
      Capybara.current_session.find('a.hero__logo', visible: :all)
      output = File.open( 'outputfile.html','w' )
      output << html
      output.close
    end
  end

  def view_article(article_title)
    Howitzer::Log.info "Open article page byb title: '#{article_title}'"
    article_link_elemnt(article_title).click #TODO:typo element
    ArticlePage.given
  end

  # def find_form_text(panel_title)
  #   panel_heading_element(panel_title).text
  # end

  def find_article_group_text(group_number)
    # binding.pry
    article_group_element(group_number).text
  end
end

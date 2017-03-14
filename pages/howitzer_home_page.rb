class HowitzerHomePage < Howitzer::Web::Page
  site 'http://howitzer-framework.io'
  path '/'
  validate :title, /\AHowitzer Framework\z/
  validate :url, %r{http://howitzer-framework\.io}
  validate :element_presence, :quick_start_btn

  element :quick_start_btn, 'a', text: 'QUICK START'
  element :install_section, '#install'

  def open_quick_start
    Howitzer::Log.info "Open Let’s get started section on Howitzer web site"
    quick_start_btn_element.click
  end
end

class MainMenuSection < Howitzer::Web::Section
  # me '.navbar-fixed-top'
  me '.navigation div.container'

  element :menu_item, :xpath, ->(name) { ".//a[.='#{name}']" }
  element :navigation_menu, '.navigation__menu'
  element :menu_small, '.navbar-toggle'
  element :menu, '#main_menu'
  element :first_link, :link, ->(text) { text }, match: :first

  def tablet_screen?
    !menu_small_elements.first.nil?
  end

  def authenticated?
    menu_small_element.click if tablet_screen?
    /LOGOUT/ === navigation_menu_element.text
  end

  def not_authenticated?
    menu_small_element.click if tablet_screen?
    /LOGIN/ === navigation_menu_element.text
  end

  def choose_menu(text)
    Howitzer::Log.info "Open '#{text}' menu"
    if tablet_screen?
      menu_small_element.click
      first_link_element(text).click
    else
      menu_item_element(text).click
    end
  end
end

class MainMenuSection < Howitzer::Web::Section
  me '.navbar-fixed-top'

  element :menu_item, :xpath, ->(name){ ".//a[.='#{name}']" }
  element :menu_small, '.navbar-toggle'
  element :menu, '#main_menu'
  element :first_link, :link, ->(text){ text }, match: :first

  def tablet_screen?
    !menu_small_elements.first.nil?
  end

  def authenticated?
    menu_small_element.click if tablet_screen?
    menu_element
    has_menu_item_element?('Logout')
  end

  def not_authenticated?
    menu_small_element.click if tablet_screen?
    menu_element
    has_no_menu_item_element?('Logout')
  end

  def choose_menu(text)
    log.info "Open '#{text}' menu"
    if tablet_screen?
      menu_small_element.click
      first_link_element(text).click
    else
      menu_item_element(text).click
    end
  end
end

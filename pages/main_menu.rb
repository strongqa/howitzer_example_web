module MainMenu
  def self.included(base)
    base.class_eval do
      element :menu, '#main_menu'
      element :menu_item, :xpath, ->(name){ ".//*[@id='main_menu']//a[.='#{name}']" }
      element :menu_small, '.navbar-toggle'
      element :error_message, '#error_explanation'
      element :flash_message, '#flash_notice'
      element :first_link, :link, ->(text){ text }, match: :first

      def self.authenticated?
        self.instance.authenticated?
      end

      def self.not_authenticated?
        self.instance.not_authenticated?
      end
    end
  end

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

  def flash_message
    flash_message_element.text
  end

  def error_message
    error_message_element.text
  end

  private

  def accept_js_confirmation
    page.execute_script 'window.confirm = function(){return true;}'
    yield
    window_confirm
  end

  def dismiss_js_confirmation
    page.execute_script 'window.confirm = function(){return false;}'
    yield
    window_confirm
  end

  def window_confirm
    page.execute_script 'return window.confirm'
  end
end

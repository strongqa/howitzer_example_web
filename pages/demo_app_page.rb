class DemoAppPage < Howitzer::Web::Page
  section :main_menu
  section :flash
  section :errors

  element :alert_text, '.alert'

  def self.authenticated?
    instance.main_menu_section.authenticated?
  end

  def self.not_authenticated?
    instance.main_menu_section.not_authenticated?
  end

  def alert_text
    alert_text_element.text
  end

  private

  def accept_js_confirmation
    execute_script 'window.confirm = function(){return true;}'
    yield
    window_confirm
  end

  def dismiss_js_confirmation
    execute_script 'window.confirm = function(){return false;}'
    yield
    window_confirm
  end

  def window_confirm
    execute_script 'return window.confirm'
  end
end

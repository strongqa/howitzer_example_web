class FlashSection < Howitzer::Web::Section
  me '.alert'

  element :flash_message, '#flash_notice'
  element :flash_alert, '#flash_alert'

  def flash_message
    flash_message_element.text
  end
end

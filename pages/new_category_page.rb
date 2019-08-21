require_relative 'demo_app_page'
class NewCategoryPage < DemoAppPage
  path '/categories/new'
  validate :title, /\ADemo web application - New Category\z/

  element :name_input, '#category_name'
  element :create_category_btn, "input[value='Create Category']"

  def create_category(name)
    Howitzer::Log.info 'Adding new category'
    name_input_element.set name
    create_category_btn_element.click
  end
end

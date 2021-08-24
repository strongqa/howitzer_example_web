require_relative 'demo_app_page'
class EditCategoryPage < DemoAppPage
  path '/categories{/id}/edit'
  validate :title, /\ADemo web application - Edit Category\z/
  validate :url, %r{/categories/\d+/edit\z}

  element :name_input, '#category_name'
  element :update_category_btn, "input[value='Update Category']"

  def update_category(name)
    Howitzer::Log.info "Update the name of the category to '#{name}'"
    name_input_element.set name
    update_category_btn_element.click
  end
end

require_relative 'demo_app_page'
class CategoriesListPage < DemoAppPage
  path '/categories/'
  validate :title, /\ADemo web application - Categories\z/

  element :new_category_button, :xpath, "//a[@href='/categories/new']"
  element :edit_btn, :xpath, ->(name) { "//div[contains(.,'#{name}')]/div/a[contains(text(), 'edit')]" }
  element :delete_btn, :xpath, ->(name) { "//div[contains(.,'#{name}')]/div/a[contains(text(), 'delete')]" }
  element :category_item, :xpath, ->(name) { "//a[.='#{name}']" }

  def add_new_category
    Howitzer::Log.info 'Adding new category'
    new_category_button_element.click
  end

  def edit_category(name)
    Howitzer::Log.info 'Editing category name'
    edit_btn_element(name).click
  end

  def delete_category(name)
    Howitzer::Log.info 'Deleting category'
    delete_btn_element(name).click
  end
end

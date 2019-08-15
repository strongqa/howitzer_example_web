require_relative 'search_page'
class CategoriesPage < SearchPage
  path '/categories{/id}'
  validate :url, %r{\/categories\/\d+\z}
end

require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    #go to categories controller, new action
    get new_category_path
    #check for new category template
    assert_template 'categories/new'
    #check that the count of categories increases by 1 after running the nested code block
    assert_difference 'Category.count', 1 do
      #redirect to categories controller, index action and create a new category with a name of sports
      post_via_redirect categories_path, category: {name: "sports"}
    end
    #check for categories index template
    assert_template 'categories/index'
    #check that categories index has sports in the response body
    assert_match "sports", response.body
  end
  
  test "invalid category submission results in failure" do
    #go to categories controller, new action
    get new_category_path
    #check for new category template
    assert_template 'categories/new'
    #check that the count of categories doesn't increase after running the nested code block
    assert_no_difference 'Category.count' do
      #post (invalid) new category to categories index page
      post categories_path, category: {name: "sp"}
    end
    #check for categories new template
    assert_template 'categories/new'
    #check that the error panel is rendered by checking for some of its components
    assert_select 'h2.panel-title'
    assert_select 'div.panel-heading'
  end
end
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  def setup
      @category = Category.new(name: "news")
  end
  
  test "category should be valid" do
    assert @category.valid?
  end
  
  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end
  
  test "name should be unique" do
    @category.save
    category2 = Category.new(name: "news")
    assert_not category2.valid?
  end
  
  test "name should not be more than 25 characters" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end
  
  test "name should not be too less than 3 characters" do
    @category.name = "aa"
    assert_not @category.valid?
  end
  
end
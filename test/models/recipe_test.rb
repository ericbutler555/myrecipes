require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  setup do
    @chef = Chef.create!(chefname: "Eric", email: "eric@chef.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.new(name: "vegetumtum", description: "great vegetarian recipe", chef_id: @chef.id) 
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "recipe without chef id should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = ""
    assert_not @recipe.valid?
  end
  
  test "description should be present" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end
  
  test "description should not be under 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end
  
  test "description should not be over 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
end

require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = Chef.create!(chefname: "Mashrur", email: "mashrur@chef.com")
    @recipe = Recipe.create(name: "vegetable saute", description: "Great vegetable saute. Add vegetables and oil.", chef: @user)
    @recipe2 = @chef.recipes.build(name: "Chicken Saute", description: "Yummy chicken dish.")
    @recipe2.save
  end
  
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end
  
  test "show list of all recipes" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
  
end

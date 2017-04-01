require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Mashrur", email: "mashrur@chef.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: "Great vegetable saute. Add vegetables and oil.", chef_id: @chef.id)
  end

  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "Some description" } }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select '.panel-body'
  end
  
  test "successfully edit a recipe" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_description = "updated description"
    patch recipe_path(@recipe, params: { recipe: { name: updated_name, description: updated_description } })
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end
  
end

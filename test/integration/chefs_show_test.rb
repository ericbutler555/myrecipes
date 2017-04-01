require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(
      chefname: "Mashrur",
      email: "mashrur@chef.com",
      password: "password",
      password_confirmation: "password"
    )
    @recipe = Recipe.create(
      name: "vegetable saute",
      description: "Great vegetable saute. Add vegetables and oil.",
      chef_id: @chef.id
    )
    @recipe2 = @chef.recipes.build(
      name: "Chicken Saute",
      description: "Yummy chicken dish."
    )
    @recipe2.save
  end
  
  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end
  
end

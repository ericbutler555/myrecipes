require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

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
  end
  
  test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "mashrur@chef.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept a valid signup" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Mashrur1", email: "mashrur1@chef.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Mashrur1", @chef.chefname
    assert_match "mashrur1@chef.com", @chef.email
  end
  
end

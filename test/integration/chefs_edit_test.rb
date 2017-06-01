require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(
      chefname: "Mashrur", 
      email: "mashrur@chef.com", 
      password: "password", 
      password_confirmation: "password"
    )
    @chef2 = Chef.create!(
      chefname: "Mashrur2", 
      email: "mashrur2@chef.com", 
      password: "password", 
      password_confirmation: "password"
    )
    @admin_user = Chef.create!(
      chefname: "Eric", 
      email: "eric@chef.com", 
      password: "password", 
      password_confirmation: "password",
      admin: true
    )
    @recipe = Recipe.create(
      name: "vegetable saute", 
      description: "Great vegetable saute. Add vegetables and oil.", 
      chef_id: @chef.id
    )
  end
  
  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "mashrur@chef.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept a valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Mashrur1", email: "mashrur1@chef.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Mashrur1", @chef.chefname
    assert_match "mashrur1@chef.com", @chef.email
  end
  
  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Mashrur3", email: "mashrur3@chef.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Mashrur3", @chef.chefname
    assert_match "mashrur3@chef.com", @chef.email
  end

  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "password")
    patch chef_path(@chef), params: { chef: { chefname: "Mashrur3", email: "mashrur3@chef.com" } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "Mashrur", @chef.chefname
    assert_match "mashrur@chef.com", @chef.email
  end
  
end

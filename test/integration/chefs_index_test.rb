require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(id: 1, chefname: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(id: 2, chefname: "john", email: "JOHN@example.com",
                    password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(id: 3, chefname: "john1", email: "JOHN1@example.com",
                    password: "password", password_confirmation: "password", admin: true)
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
  end

  test "should delete chef" do
    sign_in_as(@admin_user, "password")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end

end

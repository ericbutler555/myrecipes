require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(id: 1, chefname: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(id: 2, chefname: "john", email: "JOHN@example.com",
                    password: "password", password_confirmation: "password")
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
  end

end

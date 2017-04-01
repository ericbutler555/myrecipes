require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  setup do
    @chef = Chef.new(chefname: "Eric", email: "eric@chef.com", password: "password", password_confirmation: "password")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chef name should be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end
  
  test "chef name should be 30 characters or less" do
    @chef.chefname = "a" * 31
    assert @chef.invalid?
  end
  
  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end
  
  test "email should be 255 characters or less" do
    @chef.email = "a" * 256
    assert @chef.invalid?
  end
  
  test "email should be valid format" do
    valid_emails = %w[user@example.com MASHRUR@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |e|
      @chef.email = e
      assert @chef.valid?, "#{e.inspect} should be valid"
    end
  end
  
  test "email should reject invalid addresses" do
    invalid_emails = %w[mashrur@example mashrur@example,com mashrur.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |i|
      @chef.email = i
      assert @chef.invalid?, "#{i.inspect} should be invalid"
    end
  end
  
  test "emails should be unique" do
    @chef.save
    duplicate_chef = Chef.new(chefname: "Mashrur", email: @chef.email)
    assert duplicate_chef.invalid?
  end
  
  test "email should be case-insensitive" do
    @chef.save
    uppercase_chef = Chef.new(chefname: "Mashrur", email: @chef.email.upcase)
    assert uppercase_chef.invalid?
  end
  
  test "email should be made lowercase before saving" do
    @chef.email = "ALLCAPS@EMAIL.COM"
    @chef.save
    assert_equal @chef.email.downcase, @chef.reload.email
  end
  
  test "password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end
  
  test "password should be at least 5 characters" do
    @chef.password = @chef.password_confirmation = "a" * 4
    assert_not @chef.valid?
  end
end

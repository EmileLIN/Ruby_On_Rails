require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user= User.new(name:"ExampleUser",email:"user@example.com",password:"foobar",password_confirmation:"foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do 
    @user.name="          "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email="           "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    assert_not @user.valid?
  end

  test "email validation should accept only valid adresse" do
    valid_adresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_adresses.each do |valid_adress|
       @user.email = valid_adress
       assert @user.valid?,"#{valid_adress.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid adresse" do
    valid_adresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    valid_adresses.each do |valid_adress|
       @user.email = valid_adress
       assert_not @user.valid?,"#{valid_adress.inspect} should be valid"
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " "*6
    assert_not @user.valid?
  end

  test "password should have minimum 5 " do
    @user.password = @user.password_confirmation = "a"*5
    assert_not @user.valid?
  end
end















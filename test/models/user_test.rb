require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  setup do
    @user = User.new(:name => "name", :surname => "surname", :username => "username", :password => "789456123Oo", :email => "email@metu.edu.tr",
      :gender => "male", :phone => "111-1111111", :bulletin => false, :role => 'member', :verified => false)
  end
  
  test "isValid" do
    assert @user.valid?
  end
  
  test "empty test" do   
    @user = User.new
    assert @user.invalid? 
  end
  
  test "name invalid" do 
    @user.name = "oguz123"
    assert @user.invalid?
  end
  
  test "surname invalid" do
    @user.surname = "tanrikulu123"
    assert @user.invalid?
  end
  
  test "username invalid" do
    @user.username = "username+"
    assert @user.invalid?
  end
  
  test "password invalid" do
    @user.password = "789456123"
    assert @user.invalid?
  end
  
  test "email invalid" do
    @user.email = "oguz@asd"
    assert @user.invalid?
  end
  
  test "bulletin empty" do
    @user.bulletin = nil
    assert @user.invalid?
  end
  
  test "verified empty" do
    @user.verified = nil
    assert @user.invalid?
  end
  
  test "double username" do
    user2 = User.new(:name => "name", :surname => "surname", :username => "turbulence6th", :password => "789456123Oo", :email => "email@metu.edu.tr",
      :gender => "male", :phone => "111-1111111", :bulletin => false, :role => 'member', :verified => false)
    assert user2.invalid?
  end
  
  test "double email" do
    user2 = User.new(:name => "name", :surname => "surname", :username => "username2", :password => "789456123Oo", :email => "oguz.tanrikulu@metu.edu.tr",
      :gender => "male", :phone => "111-1111111", :bulletin => false, :role => 'member', :verified => false)
    assert user2.invalid?
  end
  
  
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  setup do
    @user = User.new(:name => "name", :surname => "surname", :username => "username", :password => "oguzTanrikulu123", 
    :password_confirmation => "oguzTanrikulu123", :email => "email@metu.edu.tr", :email_confirmation => "email@metu.edu.tr", 
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
    @user.password_confirmation = "789456123"
    assert @user.invalid?
  end
  
  test "email invalid" do
    @user.email = "oguz@asd"
    @user.email_confirmation = "oguz@asd"
    assert @user.invalid?
  end
  
  test " long email invalid" do
    @user.email = "ogussssssssssssssssssssssssssssssssssz@metu.edu.tr"
    @user.email_confirmation = "ogussssssssssssssssssssssssssssssssssz@metu.edu.tr"
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
  
  test "unmatched password" do
    @user.password_confirmation = "black"
    assert @user.invalid?
  end
  
  test "unmatched email" do
    @user.email_confirmation = "black@sad"
    assert @user.invalid?
  end
  
  test "update" do
    @user.save
    user = User.find_by_username("username")
    user.name = "nameyeni"
    user.password = "Yenipass123"
    user.password_confirmation = "Yenipass123"
    assert user.valid?
  end
  
end

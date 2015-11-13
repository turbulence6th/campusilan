require 'test_helper'

class UserControllerTest < ActionController::TestCase
 
  test "check valid username" do
    post :checkusername, :username => 'username2', :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal true, body['check']
  end
  
  test "check invalid username" do
    post :checkusername, :username => 'username2+', :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal false, body['check']
  end
  
  test "check used username" do
    post :checkusername, :username => 'turbulence6th', :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal false, body['check']
  end
  
  test "check valid email" do
    post :checkemail, :email=> 'email@metu.edu.tr', :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal true, body['check']
  end
  
  test "check invalid email" do
    post :checkemail, :email => 'email$@metu.edu.tr', :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal false, body['check']
  end
  
  test "check used email" do
    post :checkemail, :email => 'oguz.tanrikulu@metu.edu.tr', :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal false, body['check']
  end
  
  test "register user" do
    post :registerPost, :user => { :username => "username", :password => "oguzTanrikulu123", :password_confirmation => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :email_confirmation => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone1 => "123", :phone2 => "5678900", :gender => "male", :bulletin => true }
    user = User.find_by_username("username")
    assert_equal true, user!=nil
  end
  
  test "register user bulletin nil" do
    post :registerPost, :user => { :username => "username", :password => "oguzTanrikulu123", :password_confirmation => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :email_confirmation => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone1 => "123", :phone2 => "5678900", :gender => "male" }
    user = User.find_by_username("username")
    assert_equal nil, user
  end
  
  
  test "empty username" do
    post :registerPost, :user => { :password => "oguzTanrikulu123", :password_confirmation => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :email_confirmation => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone1 => "123", :phone2 => "5678900", :gender => "male", :bulletin => true }
    user = User.find_by_username("username")
    assert_equal user, nil
  end
  
  test "empty password" do
    post :registerPost, :user => { :username => "username", :password_confirmation => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :email_confirmation => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone1 => "123", :phone2 => "5678900", :gender => "male", :bulletin => true }
    user = User.find_by_username("username")
    assert_equal user, nil
  end
  
  test "empty password2" do
    post :registerPost, :user => { :username => "username", :password => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :email_confirmation => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone1 => "123", :phone2 => "5678900", :gender => "male", :bulletin => true }
    user = User.find_by_username("username")
    assert_equal user, nil
  end
  
  test "empty email" do
    post :registerPost, :user => { :username => "username", :password => "oguzTanrikulu123", :password_confirmation => "oguzTanrikulu123",
      :email_confirmation => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone1 => "123", :phone2 => "5678900", :gender => "male", :bulletin => true }
    user = User.find_by_username("username")
    assert_equal user, nil
  end
  
  test "empty email2" do
    post :registerPost, :user => { :username => "username", :password => "oguzTanrikulu123", :password_confirmation => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone1 => "123", :phone2 => "5678900", :gender => "male", :bulletin => true }
    user = User.find_by_username("username")
    assert_equal user, nil
  end

end

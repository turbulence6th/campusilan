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
    post :registerPost, :username => "username", :password => "oguzTanrikulu123", :password2 => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :email2 => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone => "123", :phone2 => "5678900", :gender => "male", :bulletin => true
    user = User.find_by_username("username")
    assert_equal true, user!=nil
  end
  
  test "empty username" do
    post :registerPost, :password => "oguzTanrikulu123", :password2 => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :email2 => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone => "123", :phone2 => "5678900", :gender => "male", :bulletin => true
    user = User.find_by_username("username")
    assert_equal user, nil
  end
  
  test "empty password" do
    post :registerPost, :username => "username", :password2 => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :email2 => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone => "123", :phone2 => "5678900", :gender => "male", :bulletin => true
    user = User.find_by_username("username")
    assert_equal user, nil
  end
  
  test "empty password2" do
    post :registerPost, :username => "username", :password => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :email2 => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone => "123", :phone2 => "5678900", :gender => "male", :bulletin => true
    user = User.find_by_username("username")
    assert_equal user, nil
  end
  
  test "empty email" do
    post :registerPost, :username => "username", :password => "oguzTanrikulu123", :password2 => "oguzTanrikulu123",
      :email2 => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone => "123", :phone2 => "5678900", :gender => "male", :bulletin => true
    user = User.find_by_username("username")
    assert_equal user, nil
  end
  
  test "empty email2" do
    post :registerPost, :username => "username", :password => "oguzTanrikulu123", :password2 => "oguzTanrikulu123",
      :email => "email@metu.edu.tr", :name => "name", :surname => "surname",
      :phone => "123", :phone2 => "5678900", :gender => "male", :bulletin => true
    user = User.find_by_username("username")
    assert_equal user, nil
  end

end

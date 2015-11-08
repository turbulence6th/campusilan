require 'test_helper'

class UniversityTest < ActiveSupport::TestCase
  
  fixtures :users
  
  setup do
    @user = User.new(:name => "name", :surname => "surname", :username => "username", :password => "oguzTanrikulu123", 
    :password_confirmation => "oguzTanrikulu123", :email => "email@metu.edu.tr", :email_confirmation => "email@metu.edu.tr", 
    :gender => "male", :phone => "111-1111111", :bulletin => false, :role => 'member', :verified => false)
    @university = University.find_by_name("ORTA DOĞU TEKNİK ÜNİVERSİTESİ")
  end
  
  test "add university" do
    @user.university = @university
    assert @user.valid?
  end
 
end

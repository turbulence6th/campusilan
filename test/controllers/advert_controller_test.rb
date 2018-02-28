require 'test_helper'

class AdvertControllerTest < ActionController::TestCase
  
  setup do
    old_controller = @controller
    @controller = UserController.new
    post :loginPost, :username => 'turbulence6th', :password => 'oguzTanrikulu123'
    @controller = old_controller
  end
  
  test "insert secondhand" do
    images = []
    test_image = 'test/images' + '/image.jpg'
    imagefile = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    images << imagefile
    post :newAdvertPost, :advert_type => 'secondhand', :advert => {:name => 'Satılık Gardrop', :price => 1200, :explication => 'Kullanılmamış garantili dolap',
      :advertable => { :category => 'beyazesya', :color => 'beyaz', :brand => 'Handy Mate', :usage => true, :warranty => true }}, :images => images
    advert = Advert.find_by_name('Satılık Gardrop')
    assert advert
  end
  
end

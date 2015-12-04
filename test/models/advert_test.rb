require 'test_helper'

class AdvertTest < ActiveSupport::TestCase
  
  setup do
    @user = User.new
    @advertable = Secondhand.new
    @advert = Advert.new(:name => 'Satılık Buzdolabı..-_*+""', :price => 1200, :explication => 'Kullanılmamış Buz dolabı satıyorum',
      :user => @user, :advertable => @advertable, :active => true)
    test_image = 'test/images' + '/image.jpg'
    imagefile = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    image = Image.new(:imagefile => imagefile)
    @advert.images << image
  end
  
  test 'valid advert' do
    assert @advert.valid?
  end
  
  test 'invalid price' do
    @advert.price = "asdsad"
    assert @advert.invalid?
  end
  
  test 'invalid price2' do
    @advert.price = 1.2
    assert @advert.invalid?
  end
  
  test 'invalid price3' do
    @advert.price = 11111111
    assert @advert.invalid?
  end
  
  test 'no explication' do
    @advert.explication = nil
    assert @advert.invalid?
  end
  
  test 'no user' do
    @advert.user = nil
    assert @advert.invalid?
  end
  
  test 'no advertable' do
    @advert.advertable = nil
    assert @advert.invalid?
  end
  
  
end

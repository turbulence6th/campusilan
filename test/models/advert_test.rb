require 'test_helper'

class AdvertTest < ActiveSupport::TestCase
  
  setup do
    @user = User.new
    @advertable = Secondhand.new
    @advert = Advert.new(:name => 'Satılık Buzdolabı..-_*+""', :price => 1200, :explication => 'Kullanılmamış Buz dolabı satıyorum',
      :user => @user, :advertable => @advertable, :active => true)
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
  
  test 'no user' do
    @advert.user = nil
    assert @advert.invalid?
  end
  
  test 'no advertable' do
    @advert.advertable = nil
    assert @advert.invalid?
  end
  
end

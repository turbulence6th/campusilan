require 'test_helper'

class SecondhandTest < ActiveSupport::TestCase
  setup do
    @advertable = Secondhand.new(:category => 'beyazesya', :color => 'siyah', :brand => 'Bosch', :usage => true, :warranty => true)
  end
  
  test 'secondhand valid' do
    assert @advertable.valid?
  end
  
  test 'no category' do
    @advertable.category = nil
    assert @advertable.invalid?
  end
  
  test 'no color' do
    @advertable.color = nil
    assert @advertable.invalid?
  end
  
  test 'no brand' do
    @advertable.brand = nil
    assert @advertable.invalid?
  end
  
  test 'no usage' do
    @advertable.usage = nil
    assert @advertable.invalid?
  end
  
  test 'no warranty' do
    @advertable.warranty = nil
    assert @advertable.invalid?
  end
end

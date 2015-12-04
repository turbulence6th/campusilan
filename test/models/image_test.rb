require 'test_helper'

class ImageTest < ActiveSupport::TestCase
    
  test "jpg image" do
    test_image = 'test/images' + '/image.jpg'
    imagefile = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    assert Image.new(:imagefile => imagefile).valid?
  end
  
  test "gif image" do
    test_image = 'test/images' + '/image2.gif'
    imagefile = Rack::Test::UploadedFile.new(test_image, "image/gif")
    assert Image.new(:imagefile => imagefile).invalid?
  end
  
  test "png image" do
    test_image = 'test/images' + '/image3.png'
    imagefile = Rack::Test::UploadedFile.new(test_image, "image/png")
    assert Image.new(:imagefile => imagefile).valid?
  end

end

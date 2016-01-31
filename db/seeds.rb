images = Image.all

images.each do |img|
  if img.user == nil
    img.user = img.imageable.user
    img.save
  end
end

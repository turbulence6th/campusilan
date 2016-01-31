images = Image.all

images.each do |img|
  if img.user == nil
    img.user = img.imageable.user if img.imageable_type=='Advert'
    img.user = img.imageable if img.imageable_type=='User'
    img.save
  end
end

desc 'Delete Empty Images'
task delete_empty_images: :environment do
  Image.where(:imageable_id => nil).destroy_all
end
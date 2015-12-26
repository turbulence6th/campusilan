ActiveAdmin.register Image do

  permit_params :imageable_type, :imagefile_file_name, :imagefile_content_type, 
    :imagefile_file_size, :imagefile_updated_at

end

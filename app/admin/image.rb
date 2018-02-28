ActiveAdmin.register Image do

  permit_params :imageable_type, :imageable_id, :imagefile_file_name, :imagefile_content_type, 
    :imagefile_file_size, :imagefile_updated_at, :user
    
  index do
    id_column
    column :imageable_type
    column :imageable_id
    column :imagefile_file_name
    column :imagefile_content_type
    column :imagefile_file_size
    column :imagefile_updated_at
    column "Images" do |image|
      image_tag image.imagefile.url(:small), :height => 100, :width => 100
    end
    actions
   end
   
   form do |f|
    inputs "Image" do
      
      input :user, :as => :select, :collection => User.select(:id, :username)

    end   

    actions
  end
  
  show do
    
      attributes_table do
          row :id
          row :imageable_type
          row :imageable_id
          row :imagefile_file_name
          row :imagefile_content_type
          row :imagefile_file_size
          row :imagefile_updated_at
          row "Images" do |image|
            image_tag image.imagefile.url(:original)
          end
         
        active_admin_comments
      end
   end

end

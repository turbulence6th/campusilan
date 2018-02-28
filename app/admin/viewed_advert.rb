ActiveAdmin.register ViewedAdvert do
  index do
    id_column
    column :user_id
    column :advert_id
    column :created_at
    actions
   end
end
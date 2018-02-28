ActiveAdmin.register ViewedAdvertCount do
  index do
    id_column
    column :ip
    column :advert_id
    actions
   end
end
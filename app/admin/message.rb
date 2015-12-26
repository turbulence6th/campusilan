ActiveAdmin.register Message do

 permit_params :from_id, :to_id, :topic, :text
 
 index do
  id_column
  column :from_id
  column :to_id
  column :topic
  column :text
  column :created_at
  column :updated_at
  actions
 end
 
 form do |f|
    inputs "Message" do

      input :from_id, :as => :select, :collection => User.select(:id, :username)
      input :to_id, :as => :select, :collection => User.select(:id, :username)
      input :topic
      input :text

    end

    actions
  end

end

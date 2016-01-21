ActiveAdmin.register Advert do

  permit_params :user_id, :advertable_id, :advertable_type, :name, :price, :explication,
    :active, :verified, :urgent, :opportunity, :ours

  form do |f|
    inputs "Advert" do

      input :user, :as => :select, :collection => User.select(:id, :username)
      input :advertable_id
      input :advertable_type
      input :name
      input :price
      input :explication
      input :active, :as => :select, :collection => { :True => true, :False => false }
      input :verified, :as => :select, :collection => { :True => true, :False => false }
      input :urgent, :as => :select, :collection => { :True => true, :False => false }
      input :opportunity, :as => :select, :collection => { :True => true, :False => false }
      input :ours, :as => :select, :collection => { :True => true, :False => false }

    end

    actions
  end

end

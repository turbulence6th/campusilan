ActiveAdmin.register User do

  permit_params :username, :password, :password_confirmation, :name, :surname, :email,
    :email_confirmation, :phone, :role, :gender, :verified, :bulletin, :birthday, :address,
    :university_id, :deleted
      
  form do |f|
    inputs "User" do
      
      input :username
      
      if object.new_record?
        input :password
        input :password_confirmation
      end
      
      input :name
      input :surname
      input :email
      
      if object.new_record?
        input :email_confirmation
      end
      
      input :phone
      input :role, :as => :select, :collection => { :Admin => :admin, :Member => :member }
      input :gender, :as => :select, :collection => { :Male => :male, :Female => :female, :Other => :other }
      input :verified, :as => :select, :collection => { :True => true, :False => false }
      input :bulletin, :as => :select, :collection => { :True => true, :False => false }
      input :birthday
      input :address
      input :deleted, :as => :select, :collection => { :True => true, :False => false }
      
      if !object.new_record?
        input :university
      end
        
    end
 
    actions
  end

end

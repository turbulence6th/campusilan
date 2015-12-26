ActiveAdmin.register Homemate do

  permit_params :state, :city, :demand
  
  form do |f|
    inputs "Homemate" do
      
      input :state
      input :city
      input :demand, :as => :select, :collection => [['Erkek', 'male'], ['Kadın', 'female'], ['Hepsi', 'both']]
      
    end
   end


end

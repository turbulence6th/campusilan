ActiveAdmin.register Advert, :as => "Advert Verify" do
	
	scope_to do
    Advert.all
  end


end
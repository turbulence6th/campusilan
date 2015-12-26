ActiveAdmin.setup do |config|


  config.site_title = "Campusilan"
  config.site_title_link  = "/"

  config.authentication_method = :authenticate_admin_user!

 
  config.current_user_method = :current_admin_user


  config.logout_link_path = '/logout'

  
  config.localize_format = :long

  
end

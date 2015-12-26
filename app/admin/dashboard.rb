ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
   

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
       column do
         panel "Recent Adverts" do
           ul do
             Advert.last(5).map do |advert|
               li link_to(advert.name, "/admin/adverts/" + advert.id.to_s)
             end
           end
         end
       end

       column do
         panel "Recent Users" do
           ul do
             User.last(5).map do |user|
               li link_to(user.username, "/admin/users/" + user.id.to_s)
             end
           end
         end
       end
       
       column do
         panel "Most Popular Adverts" do
           ul do
              @mostpopular = []
    
              popularList = ViewedAdvertCount.group(:advert_id).count.first(6)
              
              popularList.each do |id, count|
                @mostpopular << Advert.find(id)
              end
             @mostpopular.map do |advert|
               li link_to(advert.name, "/admin/adverts/" + advert.id.to_s)
             end
           end
         end
       end
       
     end
  end # content
end

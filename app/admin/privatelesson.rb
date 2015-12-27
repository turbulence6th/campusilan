ActiveAdmin.register Privatelesson do

permit_params :kind, :lecture, :state, :city, :location
  
  form do |f|
    inputs "Privatelesson" do
      
      input :lecture, :as => :select, :collection => [['Matematik', 'matematik'], ['Fizik', 'fizik'], ['Kimya', 'kimya'],
        ['Biyoloji','biyoloji'],['Genel Mühendislik','genelmuhendislik'],['Genel Eğitim Bilimleri','genelegitimbilimleri']]
      input :state
      input :city
      input :kind, :as => :select, :collection => [['Birebir', 'birebir'], ['Grup', 'grup'], ['Sınıf Dersi', 'sinifdersi']]
      input :location, :as => :select, :collection => [['Öğrenci Evinde', 'ogrencievi'], ['Öğretmenin Evinde', 'ogretmenevi'], ['Sınıfta', 'sinifta']]
      
    end
 
    actions
  end

end

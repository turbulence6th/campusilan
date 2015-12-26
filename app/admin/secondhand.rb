ActiveAdmin.register Secondhand do
  
  permit_params :category, :color, :brand, :usage, :warranty
  
  form do |f|
    inputs "Secondhand" do
      
      input :category, :as => :select, :collection => [['Beyaz Eşya', 'beyazesya'], ['Ev Dekorasyonu',
                  'evdekorasyon'], ['Müzik Aletleri', 'muzikaletleri'], ['Elektronik', 'elektronik'], ['Kırtasiye', 'kirtasiye'],
                ['Mutfak Eşyaları', 'mutfakesyalari'], ['Vasıta', 'vasita'],['Giyim', 'giyim'],['Ders Notu', 'dersnotu'], ['Diğer', 'diger']]
      input :color, :as => :select, :collection => [['Siyah', 'siyah'], ['Beyaz', 'beyaz'], ['Kırmızı','kirmizi'],
              ['Mavi', 'mavi'], ['Sarı', 'sari'], ['Yeşil', 'yesil']]
      input :brand
      input :usage, :as => :select, :collection => { :True => true, :False => false }
      input :warranty, :as => :select, :collection => { :True => true, :False => false }
      
    end
 
    actions
  end
  

end

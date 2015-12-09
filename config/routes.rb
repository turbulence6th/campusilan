Rails.application.routes.draw do
  get '/' => 'index#index'
  get 'aramasonuclari' => 'index#aramasonuclari'
  get 'hakkimizda' => 'index#hakkimizda'
  get 'iletisim' => 'index#iletisim'
  get 'kullanimkosullari' => 'index#kullanimkosullari'
  get 'reklam' => 'index#reklam'
  
  get 'yardim' => 'index#yardim'
  get 'ilanver' => 'advert#ilanver'
  post 'secondhand' => 'advert#secondhandPost'
  post 'homemate' => 'advert#homematePost'
  post 'lecturenote' => 'advert#lecturenotePost'
  post 'privatelesson' => 'advert#privatelessonPost'
  get 'satis-alis' => 'index#satis_alis'
  get 'satis-alis/:satislarim' => 'index#satis_alis'
  get 'satis-alis/:alislarim' => 'index#satis_alis'
  
  get 'mesajlarim' => 'index#mesajlarim'
  get 'girisyap' => 'user#login'
  
  get 'kayitol' => 'user#register'
  post 'checkusername' => 'user#checkusername', defaults: {format: :json}
  post 'checkemail' => 'user#checkemail', defaults: {format: :json}
  post 'register' => 'user#registerPost'
  post 'login' => 'user#loginPost'
  get 'logout' => 'user#logout'
  post 'updateUser' => 'user#updateUser'
  
  get 'ikinciel/:advert_name' => 'advert#ikinciel'
  get 'dersnotu/:advert_name' => 'advert#dersnotu'
  get 'evarkadasi/:advert_name' => 'advert#evarkadasi'
  get 'ozelders/:advert_name' => 'advert#ozelders'
  get 'kategoriler/:kategori' => 'advert#kategoriler'
  get 'kategoriler' => 'advert#kategoriler'
  get 'kategoriler/ikincielilan/:subkategori' => 'advert#kategoriler'  
  get 'firsatlar' => 'advert#firsatlar'
  get 'uye/:username' => 'user#member'
  
  get 'insert_image' => 'index#insert_image'
  post 'insert_image' => 'index#insert_image_post'
  
  get 'administrator' => 'admin#index'
  
  get 'administrator/ilanlar' => 'admin#ilanlar'
  
  get 'administrator/uyeler' => 'admin#uyeler'
    
  get 'administrator/yorumlar' => 'admin#yorumlar'
  
  
  get 'administrator/bootstrapelements' => 'admin#bootstrap_elements'
  
  get 'administrator/charts' => 'admin#charts'
  
  get 'administrator/forms' => 'admin#forms'
  
  get 'administrator/indexrtl' => 'admin#index_rtl'
  
  get 'administrator/tables' => 'admin#tables'
  
  

end

Rails.application.routes.draw do
  get '/' => 'index#index'
  get 'aramasonuclari' => 'index#aramasonuclari'
  get 'hakkimizda' => 'index#hakkimizda'
  get 'iletisim' => 'index#iletisim'
  get 'kullanimkosullari' => 'index#kullanimkosullari'
  get 'reklam' => 'index#reklam'
  
  get 'yardim' => 'index#yardim'
  get 'ilanver' => 'index#ilanver'
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
  
  get 'ikinciel/:advert_name' => 'advert#ikinciel'
  get 'dersnotu/:advert_name' => 'advert#dersnotu'
  get 'evarkadasi/:advert_name' => 'advert#evarkadasi'
  get 'ozelders/:advert_name' => 'advert#ozelders'
  get 'kategoriler/:kategori' => 'advert#kategoriler'
  get 'kategoriler' => 'advert#kategoriler'
  get 'kategoriler/ikincielilan/:subkategori' => 'advert#kategoriler'  
  get 'firsatlar' => 'advert#firsatlar'
  get 'uye/:username' => 'user#member'
  
  
 
  
  
  
  
  
  
  
  
  
  
end

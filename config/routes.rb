Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get '/' => 'index#index'
  get 'aramasonuclari' => 'index#aramasonuclari'
  
  get 'hakkimizda' => 'index#hakkimizda'
  get 'iletisim' => 'index#iletisim'
  get 'kullanimkosullari' => 'index#kullanimkosullari'
  get 'reklam' => 'index#reklam'
  
  get 'yardim' => 'index#yardim'
  get 'ilanver' => 'advert#ilanver'
  get 'ilanguncelle/:advert_name' => 'advert#ilanguncelle'
  post 'ilanguncelle/:advert_type' => 'advert#ilanguncellePost'
  post 'deleteimage' => 'advert#deleteimage', defaults: {format: :json}
  post 'secondhand' => 'advert#secondhandPost'
  post 'homemate' => 'advert#homematePost'
  post 'privatelesson' => 'advert#privatelessonPost'
  get 'satis-alis' => 'index#satis_alis'
  get 'satis-alis/:satislarim' => 'index#satis_alis'
  get 'satis-alis/:alislarim' => 'index#satis_alis'
  
  get 'mesajlarim' => 'index#mesajlarim'
  
  post 'mesajgonder' => 'index#mesajPost', defaults: {format: :json}
  get 'girisyap' => 'user#login'
  
  get 'kayitol' => 'user#register'
  post 'checkusername' => 'user#checkusername', defaults: {format: :json}
  post 'checkemail' => 'user#checkemail', defaults: {format: :json}
  post 'register' => 'user#registerPost'
  post 'login' => 'user#loginPost'
  get 'logout' => 'user#logout'
  post 'updateUser' => 'user#updateUser'
  get 'verify' => 'user#verify'
  
  get 'ikinciel/:advert_name' => 'advert#ikinciel'
  post 'favorilereekle' => 'advert#favorilereekle', defaults: {format: :json}
  post 'favorilerdenkaldir' => 'advert#favorilerdenkaldir', defaults: {format: :json}
  get 'evarkadasi/:advert_name' => 'advert#evarkadasi'
  get 'ozelders/:advert_name' => 'advert#ozelders'
  get 'kategoriler/:kategori' => 'advert#kategoriler'
  get 'kategoriler' => 'advert#kategoriler'
  get 'kategoriler/:kategori/:subkategori' => 'advert#kategoriler'  
  get 'firsatlar' => 'advert#firsatlar'
  get 'uye/:username' => 'user#member'

  get "/404" => "error#not_found"
  get "/422" => "error#unacceptable"
  get "/500" => "error#internal_error"

  
  
  

end

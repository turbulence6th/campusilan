Rails.application.routes.draw do
  get '/' => 'index#index'
  get 'aramasonuclari' => 'index#aramasonuclari'
  get 'hakkimizda' => 'index#hakkimizda'
  get 'firsatlar' => 'index#firsatlar'
  get 'iletisim' => 'index#iletisim'
  get 'kullanimkosullari' => 'index#kullanimkosullari'
  get 'reklam' => 'index#reklam'
  get 'uye' => 'user#member'
  get 'yardim' => 'index#yardim'
  get 'ilanver' => 'index#ilanver'
  get 'satis-alis' => 'index#satis-alis'
  get 'mesajlarim' => 'index#mesajlarim'
  get 'girisyap' => 'user#login'
  
  get 'kayitol' => 'user#register'
  post 'checkusername' => 'user#checkusername', defaults: {format: :json}
  post 'checkemail' => 'user#checkemail', defaults: {format: :json}
  post 'register' => 'user#registerPost'
  post 'login' => 'user#loginPost'
  get 'logout' => 'user#logout'
  
end

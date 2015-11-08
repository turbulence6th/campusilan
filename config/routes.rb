Rails.application.routes.draw do
  get '/' => 'index#index'
  get 'aramasonuclari' => 'index#search'
  get 'hakkimizda' => 'index#info'
  get 'firsatlar' => 'index#opportunity'
  get 'iletisim' => 'index#contact'
  get 'kullanimkosullari' => 'index#terms'
  get 'reklam' => 'index#advert'
  get 'uye' => 'user#member'
  get 'yardim' => 'index#help'
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

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
  post 'imagetotop' => 'advert#imagetotop', defaults: {format: :json}
  post 'newadvert/:advert_type' => 'advert#newAdvertPost'
  get 'satis-alis' => 'index#satis_alis'
  get 'satis-alis/:satislarim' => 'index#satis_alis'
  get 'satis-alis/:alislarim' => 'index#satis_alis'
  get 'ilanonay' => 'user#ilanonay'
  post 'ilanonay' => 'user#ilanonay'
  post 'ilansil' => 'user#ilansil'

  get 'mesajlarim' => 'index#mesajlarim'

  post 'mesajgonder' => 'index#mesajPost', defaults: {format: :json}
  post 'mesajsil' => 'index#mesajSil', defaults: {format: :json}
  get 'girisyap' => 'user#login'
  get 'aktivasyon' => 'user#aktivasyon'
  post 'aktivasyon' => 'user#aktivasyonpost'
  get 'sifredegistir' => 'user#sifredegistir'
  post 'sifredegistir' => 'user#sifredegistirPost'
  get 'sifremiunuttum' => 'user#sifremiunuttum'
  post 'sifremiunuttum' => 'user#sifremiunuttumPost'
  get 'risksizalisveris' => 'index#risksizalisveris'
  get 'duyurular' => 'index#duyurular'
  get 'hizmetlerimiz' => 'index#hizmetlerimiz'
  

  get 'kayitol' => 'user#register'
  post 'checkusername' => 'user#checkusername', defaults: {format: :json}
  post 'checkemail' => 'user#checkemail', defaults: {format: :json}
  post 'register' => 'user#registerPost'
  post 'login' => 'user#loginPost'
  get 'logout' => 'user#logout'
  post 'updateUser' => 'user#updateUser'
  get 'verify' => 'user#verify'
  get 'forgot' => 'user#sifremiunuttumPost'

  get 'ikinciel/:advert_name' => 'advert#ilan'
  post 'favorilereekle' => 'advert#favorilereekle', defaults: {format: :json}
  post 'favorilerdenkaldir' => 'advert#favorilerdenkaldir', defaults: {format: :json}
  get 'evarkadasi/:advert_name' => 'advert#ilan'
  get 'ozelders/:advert_name' => 'advert#ilan'
  get 'kategoriler/:kategori' => 'advert#kategoriler'
  get 'kategoriler' => 'advert#kategoriler'
  get 'kategoriler/:kategori/:subkategori' => 'advert#kategoriler'
  get 'firsatlar' => 'advert#firsatlar'
  get 'uye/:username' => 'user#member', :constraints => { :username => /[^\/]+/ }
  post 'profilephoto' => 'user#profilephoto'
  get 'universiteler' => 'index#universiteler'
  post 'vote' => 'advert#vote', defaults: {format: :json}
  post '/uye/hesabisil' => 'user#hesabisil'
  get 'favorilerim' => 'index#favorilerim'
  get 'ilanlarim' => 'index#ilanlarim'
  get 'incelediklerim' => 'index#incelediklerim'
  post 'votedelete' => 'advert#votedelete', defaults: {format: :json}
  post 'iletisim' => 'index#iletisimPost'
  post 'closeadvert' => 'advert#close', defaults: {format: :json}
  
  post 'imageupload' => 'advert#imageupload', defaults: {format: :json}
  post 'guncelleimageupload' => 'advert#guncelleimageupload', defaults: {format: :json}

  get "404" => "error#not_found"
  get "422" => "error#unacceptable"
  get "500" => "error#internal_error"

end

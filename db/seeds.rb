odtu = University.new( :name => 'ORTA DOĞU TEKNİK ÜNİVERSİTESİ' )
odtu.save

oguz = User.new( :username => "turbulence6th", :password => "oguzTanrikulu123", :password_confirmation => "oguzTanrikulu123", :email => "oguz.tanrikulu@metu.edu.tr",
  :email_confirmation => "oguz.tanrikulu@metu.edu.tr", :name => "Oğuz", :surname => "Tanrıkulu", :gender => :male, :bulletin => true, :phone => "538-3595977", 
  :verified => true, :birthday => Time.new(1994, 4, 3 ), :role => :admin )
oguz.university = University.find_by_name('ORTA DOĞU TEKNİK ÜNİVERSİTESİ')
oguz.save
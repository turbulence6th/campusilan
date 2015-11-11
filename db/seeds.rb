odtu = University.new( :name => 'ORTA DOĞU TEKNİK ÜNİVERSİTESİ' )
odtu.save

oguz = User.new( :username => "turbulence6th", :password => "oguzTanrikulu123", :password_confirmation => "oguzTanrikulu123", :email => "oguz.tanrikulu@metu.edu.tr",
  :email_confirmation => "oguz.tanrikulu@metu.edu.tr", :name => "Oğuz", :surname => "Tanrıkulu", :gender => :male, :bulletin => true, :phone => "538-3595977", 
  :verified => true, :birthday => Time.new(1994, 4, 3 ), :role => :admin )
oguz.university = University.find_by_name('ORTA DOĞU TEKNİK ÜNİVERSİTESİ')
oguz.save







onur = User.new( :username => "svmszcck", :password => "1234Onur1234", :password_confirmation => "1234Onur1234", :email => "demirtas.onur@metu.edu.tr",
  :email_confirmation => "demirtas.onur@metu.edu.tr", :name => "Onur", :surname => "Demirtaş", :gender => :male, :bulletin => true, :phone => "505-7822777", 
  :verified => true, :birthday => Time.new(1991, 8, 14 ), :role => :admin )
onur.university = University.find_by_name('ORTA DOĞU TEKNİK ÜNİVERSİTESİ')
onur.save 
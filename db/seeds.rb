odtu = University.new( :name => 'ORTA DOĞU TEKNİK ÜNİVERSİTESİ', :email => 'metu.edu.tr' )
odtu.save

University.create(:name => 'ABANT İZZET BAYSAL ÜNİVERSİTESİ', :email => 'ibu.edu.tr')
University.create(:name => 'ABDULLAH GÜLL ÜNİVERSİTESİ', :email => 'agu.edu.tr')
University.create(:name => 'ACIBADEM ÜNİVERSİTESİ', :email => 'acibadem.edu.tr')
University.create(:name => 'ADANA BİLİM VE TEKNOLOJİ ÜNİVERSİTESİ', :email => 'adanabtu.edu.tr')
University.create(:name => 'ADIYAMAN ÜNİVERSİTESİ', :email => 'adiyaman.edu.tr')
University.create(:name => 'ADNAN MENDERES ÜNİVERSİTESİ', :email => 'adu.edu.tr')
University.create(:name => 'AFYON KOCATEPE ÜNİVERSİTESİ', :email => 'aku.edu.tr')
University.create(:name => 'AĞRI İBRAHİM ÇEÇEN ÜNİVERSİTESİ', :email => 'agri.edu.tr')
University.create(:name => 'AHİ EVRAN ÜNİVERSİTESİ', :email => 'ahievran.edu.tr')
University.create(:name => 'AKDENİZ ÜNİVERSİTESİ', :email => 'akdeniz.edu.tr')
University.create(:name => 'AKSARAY ÜNİVERSİTESİ', :email => 'aksaray.edu.tr')
#University.create(:name => 'ALANYA ALAADDİN KEYKUBAT ÜNİVERSİTESİ', :email => 'akdeniz.edu.tr')
University.create(:name => 'ALANYA HAMDULLAH EMİN PAŞA ÜNİVERSİTESİ', :email => 'ahep.edu.tr')
University.create(:name => 'AMASYA ÜNİVERSİTESİ', :email => 'amasya.edu.tr')
University.create(:name => 'ANADOLU ÜNİVERSİTESİ', :email => 'anadolu.edu.tr')
#University.create(:name => 'ANKA TEKNOLOJİ ÜNİVERSİTESİ', :email => '')
University.create(:name => 'ANKARA SOSYAL BİLİMLER ÜNİVERSİTESİ', :email => 'asbu.edu.tr')
University.create(:name => 'ANKARA ÜNİVERSİTESİ', :email => 'ankara.edu.tr')
#University.create(:name => 'ANTALYA AKEV ÜNİVERSİTESİ', :email => 'adiyaman.edu.tr')
University.create(:name => 'ARDAHAN ÜNİVERSİTESİ', :email => 'ardahan.edu.tr')
University.create(:name => 'ARTVİN ÇORUH ÜNİVERSİTESİ', :email => 'artvin.edu.tr')
University.create(:name => 'ATAŞEHİR ADIGÜZEL MESLEK YÜKSEKOKULU', :email => 'adiguzel.edu.tr')
University.create(:name => 'ATATÜRK ÜNİVERSİTESİ', :email => 'atauni.edu.tr')
University.create(:name => 'ATILIM ÜNİVERSİTESİ', :email => 'atilim.edu.tr')
University.create(:name => 'AVRASYA ÜNİVERSİTESİ', :email => 'avrasya.edu.tr')
University.create(:name => 'AVRUPA MESLEK YÜKSEKOKULU', :email => 'avrupa.edu.tr')
University.create(:name => 'BAHÇEŞEHİR ÜNİVERSİTESİ', :email => 'bahcesehir.edu.tr')
University.create(:name => 'BALIKESİR ÜNİVERSİTESİ', :email => 'balikesir.edu.tr')
University.create(:name => 'BANDIRMA ONYEDİ EYLÜL ÜNİVERSİTESİ', :email => 'bandirma.edu.tr')
University.create(:name => 'BARTIN ÜNİVERSİTESİ', :email => 'bartin.edu.tr')


oguz = User.new( :username => "turbulence6th", :password => "oguzTanrikulu123", :password_confirmation => "oguzTanrikulu123", :email => "oguz.tanrikulu@metu.edu.tr",
  :email_confirmation => "oguz.tanrikulu@metu.edu.tr", :name => "Oğuz", :surname => "Tanrıkulu", :gender => :male, :bulletin => true, :phone => "538-3595977", 
  :verified => true, :birthday => Time.new(1994, 4, 3 ), :role => :admin )
oguz.university = University.find_by_email('metu.edu.tr')
oguz.save







onur = User.new( :username => "svmszcck", :password => "1234Onur1234", :password_confirmation => "1234Onur1234", :email => "demirtas.onur@metu.edu.tr",
  :email_confirmation => "demirtas.onur@metu.edu.tr", :name => "Onur", :surname => "Demirtaş", :gender => :male, :bulletin => true, :phone => "505-7822777", 
  :verified => true, :birthday => Time.new(1991, 8, 14 ), :role => :admin )
onur.university = University.find_by_email('metu.edu.tr')
onur.save 
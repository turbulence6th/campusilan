class Homemate < ActiveRecord::Base

  validates :state, :city, :demand, :sleep, :friend, :smoke, :department, :music, :presence => true

  validates :state, :city, :format => {
    :with => /\A[a-zA-Z0-9.-_ \u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,20}\z/
  }

  has_one :advert, :as => :advertable

  enum :demand => [ :male, :female, :both ]

  enum :sleep => [ :evet1, :hayir1, :degisken1 ]
  enum :friend => [ :evet2, :hayir2, :degisken2 ]
  enum :smoke => [ :evet3, :hayir3, :arada3 ]
  enum :department => [ :muhendislik, :egitim, :tip, :siyasal, :diger ]
  enum :music => [ :evet4, :hayir4, :arada4 ]
  def aranan

    if self.demand == 'male'

      return 'Erkek'

    elsif self.demand == 'female'

      return 'Kadın'

    elsif self.demand == 'both'

      return 'Hepsi'

    end

  end

  def uyuma

    if self.sleep == 'evet1'

      return "Evet"

    elsif self.sleep == 'hayir1'

      return "Hayır"

    elsif self.sleep == 'degisken1'

      return "Değişken"

    end

  end

  def arkadas

    if self.friend == 'evet2'

      return "Evet"

    elsif self.friend == 'hayir2'

      return "Hayır"

    elsif self.friend == 'degisken2'

      return "Değişken"

    end

  end

  def sigara

    if self.smoke == 'evet3'

      return "Evet"

    elsif self.smoke == 'hayir3'

      return "Hayır"

    elsif self.smoke == 'degisken3'

      return "Değişken"

    end

  end

  def muzik

    if self.music == 'evet4'

      return "Evet"

    elsif self.music == 'hayir4'

      return "Hayır"

    elsif self.music == 'degisken4'

      return "Değişken"

    end

  end

end

class AdvertController < ApplicationController

  layout false

  helper_method :current_user
  def ikinciel

  end

  def dersnotu

  end

  def evarkadasi

  end

  def ozelders

  end

  def kategoriler

    kategori=params[:kategori]

    if kategori=="ikincielilan"

      @title="İkinci El İlanlar"

    elsif kategori=="dersnotu"

      @title="Ders Notları"

    elsif kategori=="evarkadasi"

      @title="Ev Arkadaşı İlanları"

    elsif kategori=="ozelders"

      @title="Özel Ders İlanları"

    elsif kategori==nil

      @title="İkinci El İlanlar"

    else

      redirect_to "/kategoriler"

    end

    subkategori=params[:subkategori]

    if subkategori=="beyazesya"

      @title="Beyaz Eşya"

    elsif subkategori=="evdekorasyonu"

      @title="Ev Dekorasyonu"

    elsif subkategori=="muzikaletleri"

      @title="Müzik Aletleri"

    elsif subkategori=="elektronik"

      @title="Elektronik"

    elsif subkategori=="kirtasiye"

      @title="Kırtasiye"

    elsif subkategori=="mutfakesyalari"

      @title="Mutfak Eşyaları"

    elsif subkategori=="diger"

      @title="Diğer"

    end

  end

end

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
    
    
    
    
    
  end

 

end

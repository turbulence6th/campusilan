class AdvertController < ApplicationController

  layout false
  def ikinciel
    @user = User.find_by_id(session[:user_id])
  end

  def dersnotu
    @user = User.find_by_id(session[:user_id])
  end

  def evarkadasi
    
  end

  def ozelders

  end

  def kategoriler
    @user = User.find_by_id(session[:user_id])
    
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

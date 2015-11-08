class IndexController < ApplicationController

  layout false
  def index

    @user = User.find_by_id(session[:user_id])

  end

  def firsatlar

    @user=User.find_by_id(session[:user_id])

    if params[:acililanlar]!=nil

      @title="Acil İlanlar"

      @ilanlar=[]

    elsif params[:gununfirsatlari]!=nil

      @title="Günün Fırsatları"

      @ilanlar=[]

    elsif params[:ensonilanlar]!=nil

      @title="En Son İlanlar"

      @ilanlar=[]

    elsif params[:enpopulerilanlar]!=nil

      @title="En Popüler İlanlar"

      @ilanlar=[]
      
      
      elsif params[:fiyatidusenler]!=nil
      
      
      @title="Fiyatı Düşenler"
      
      @ilanlar=[]   
      
      
      else
        
        @title="Acil İlanlar"
      
      @ilanlar=[]
      
      
      
      
      

    end

  end

end

class IndexController < ApplicationController
  
  layout false
  
  def index
    
    puts User.find(1).valid?
    
  end
  
  helper_method :current_user

  def firsatlar

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

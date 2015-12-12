class AdminController < ApplicationController
  
  before_filter :authenticate
  
  helper_method :current_user

  def authenticate
    if !current_user || current_user.role != 'admin'
      raise ActionController::RoutingError.new('Not Found')
    end
  end
  
  def index
    
  end
  
  
  
  def bootstrap_elements
    
  end
  
  def bootstrap_grid
    
  end
  
  def charts
    
  end
  
  
  def forms
    
  end
  
  def index_rtl
    
  end
  
  def tables  
    
    @sonilanlar = Advert.order('created_at DESC').limit(7)
    @sonuyeler = User.order('created_at DESC').limit(7)
    
  end  
  
  def ilanlar
    
    @page = 1
    @page = params[:page].to_i if params[:page]
    
    @search =''
    @search = params[:search] if params[:search]
    
    
    @totalpage = (Advert.where("name LIKE ?", "%" + @search + "%").count/10.0).ceil
    @ilanlar = Advert.where("name LIKE ?", "%" + @search + "%").order('created_at DESC')[(@page-1)*10..(@page-1)*10+9]
   
    
  end  
  
  def yorumlar
    
  end
  
  def uyeler
    
    @sonilanlar = Advert.order('created_at DESC').limit(7)
    @sonuyeler = User.order('created_at DESC').limit(7)
    
    
  end
    
          
  
end
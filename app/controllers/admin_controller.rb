class AdminController < ApplicationController
  
  before_filter :authenticate

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
    
    @sonilanlar = Advert.order('created_at DESC').limit(7)
    @sonuyeler = User.order('created_at DESC').limit(7)
    
  end  
  
  def yorumlar
    
  end
  
  def uyeler
    
    @sonilanlar = Advert.order('created_at DESC').limit(7)
    @sonuyeler = User.order('created_at DESC').limit(7)
    
    
  end
    
          
  
end
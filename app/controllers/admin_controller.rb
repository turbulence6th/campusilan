class AdminController < ApplicationController
  
  before_filter :authenticate

  def authenticate
    if !current_user || current_user.role != 'admin'
      raise ActionController::RoutingError.new('Not Found')
    end
  end
  
  def index
    
  end
  
  def blank_page
    
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
    
  end  
    
          
  
end
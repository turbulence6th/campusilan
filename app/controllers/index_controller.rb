class IndexController < ApplicationController
  
  layout false
  
  def index
    
    @user = User.find_by_id(session[:user_id])
   
  end
  
  def firsatlar
    
    @user=User.find_by_id(session[:user_id])
    
  end
  
end

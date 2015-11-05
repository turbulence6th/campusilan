class IndexController < ApplicationController
  
  layout false
  
  def index
    @user = User.find_by_id(session[:user_id])
    
    user1 = User.find_by_id(4)
    user2 = User.find_by_id(2)
    
    user1.destroy
    
    
  end
end

class IndexController < ApplicationController

  layout false

  helper_method :current_user
  def index
      puts session[:key]

  end

 

end

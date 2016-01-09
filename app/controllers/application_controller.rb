class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :topUniversities
   
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authenticate_admin_user! #use predefined method name
    if !current_user || current_user.role!='admin'
      raise ActionController::RoutingError.new('Not Found')
    end
  end 
  
  def current_admin_user #use predefined method name
    return nil if !current_user || current_user.role!='admin' 
    current_user 
  end 
  
  def path_exists?(path)
    begin
      Rails.application.routes.recognize_path(path)
    rescue
      return false
    end
    
    true
  end
  
  def topUniversities
    sql = "SELECT universities.id, universities.name, COUNT(*) " + 
      "FROM adverts LEFT JOIN users ON adverts.user_id=users.id, universities " +
      "WHERE users.university_id=universities.id "+
      "GROUP BY universities.id, universities.name "+
      "ORDER BY COUNT(*) ASC"
      
    arr = ActiveRecord::Base.connection.execute(sql)
  end
  
  def ensonikinciel
    Advert.available.where(advertable_type: 'Secondhand').order('created_at DESC')
  end
  
  def ensonevarkadasi
    Advert.available.where(advertable_type: 'Homemate').order('created_at DESC')
  end
  
  def ensonozelders
    Advert.available.where(advertable_type: 'Privatelesson').order('created_at DESC')
  end
  
  def ensonilanlar
    Advert.available.order('created_at DESC')
  end
  
  def acililanlar
    Advert.available.where(:urgent => true).order('created_at DESC')
  end
  
  def gununilanlari
    Advert.available.where(:opportunity => true).order('created_at DESC')
  end
  
  def mostpopular
    Advert.available.select('adverts.*').from('adverts, viewed_advert_counts v')
      .where('adverts.id=v.advert_id').group('adverts.id').order('count(*) desc')
  end
  
  def bizimsectiklerimiz
    Advert.available.where(:ours => true).order('created_at DESC')
  end
  
 
  
end

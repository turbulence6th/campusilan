class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :topUniversities
  
  before_filter :check_admin_mode,
    :set_start_time, :if => proc {|c| current_user && current_user.role == 'admin' }
  
  before_filter :check_admin_mode

  def check_admin_mode
    if ENV['ADMIN_MODE'] && (!current_user || current_user.role != 'admin')
      redirect_to '/portfolio'
    end
  end

  def set_start_time
    @start_time = Time.now.to_f
  end
   
  def current_user
    
    if @current_user 
      return @current_user
    else
      if session[:expires_at] && session[:expires_at] < Time.current
        reset_session
        @current_user = nil
      elsif session[:expires_at] && session[:expires_at] >= Time.current
        session[:expires_at] = 10.minutes.from_now
        @current_user = User.valid.find_by(:id => session[:user_id])
      else
        @current_user = User.valid.find_by(:id => session[:user_id])
      end
    end
    
 
    
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
  
  
  def topUniversities
    sql = "select universities.id, universities.name, count(universities)" + 
      "from universities, adverts, users " + 
      "where adverts.user_id = users.id AND users.university_id = universities.id " +
      "group by universities.id " + 
      "order by count(universities) DESC " +
      "limit 7" 
      Rails.cache.fetch("top_universities", :expires_in => 5.minutes) do
        ActiveRecord::Base.connection.select_rows(sql)
      end
   
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
      .where('adverts.id=v.advert_id').group('adverts.id').order('count(*) DESC, created_at ASC')
  end
  
  def bizimsectiklerimiz
    Advert.available.where(:ours => true).order('created_at DESC')
  end
  
  def enguvenilirikinciel
    User.valid.select('users.*').from('users, adverts, votes')
      .where('adverts.advertable_type=? AND users.id=adverts.user_id AND votes.advert_id=adverts.id', 'Secondhand')
      .group('users.id').having('count(votes)>=10').order('AVG(votes.point) DESC')
  end
  
  def enguvenilirevarkadasi
    User.valid.select('users.*').from('users, adverts, votes')
      .where('adverts.advertable_type=? AND users.id=adverts.user_id AND votes.advert_id=adverts.id', 'Homemate')
      .group('users.id').having('count(votes)>=10').order('AVG(votes.point) DESC')
  end
  
  def enguvenilirozelders
    User.valid.select('users.*').from('users, adverts, votes')
      .where('adverts.advertable_type=? AND users.id=adverts.user_id AND votes.advert_id=adverts.id', 'Privatelesson')
      .group('users.id').having('count(votes)>=10').order('AVG(votes.point) DESC')
  end
  
  def enguvenilir
    User.valid.select('users.*').from('users, adverts, votes')
      .where('users.id=adverts.user_id AND votes.advert_id=adverts.id')
      .group('users.id').having('count(votes)>=10').order('AVG(votes.point) DESC')
  end
  
  def kendiuniversitem
    Advert.available.select('adverts.*').from('adverts, users')
          .where('users.university_id = ? and adverts.user_id=users.id', current_user.university_id)
          .order('created_at DESC')
  end
  
  
end

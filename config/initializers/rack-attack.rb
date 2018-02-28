class Rack::Attack
  
  Rack::Attack.throttle('logins/ip', :limit => 5, :period => 120.seconds) do |req|
    if req.path == '/login' && req.post?
      req.ip
    end
  end
  
  Rack::Attack.throttle('register/ip', :limit => 5, :period => 120.seconds) do |req|
    if req.path == '/register' && req.post?
      req.ip
    end
  end
  
  Rack::Attack.throttle('req/ip', :limit => 5, :period => 1.seconds) do |req|
    req.ip
  end
  
end
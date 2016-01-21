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
  
  Rack::Attack.throttled_response = lambda do |env|
    # name and other data about the matched throttle
    body = [
      env['rack.attack.matched'],
      env['rack.attack.match_type'],
      env['rack.attack.match_data']
    ].inspect
  
    # Using 503 because it may make attacker think that they have successfully
    # DOSed the site. Rack::Attack returns 429 for throttling by default
    [ 503, {}, [body]]
  end
  
end
class Rack::Attack
  # Throttle all requests by IP (60rpm)
  throttle('req/ip', limit: 60, period: 1.minute) do |req|
    req.ip
  end

  # Exponential backoff throttle
  # Allows 20 requests in 8  seconds
  #        40 requests in 64 seconds
  #        ...
  #        100 requests in 0.38 days (~250 requests/day)
  (1..5).each do |level|
    throttle("books/ip/#{level}", limit: (20 * level), period: (8 ** level).seconds) do |req|
      req.ip if req.post?
    end
  end
end

class Rack::Attack::Request < ::Rack::Request
  def localhost?
    ip == "127.0.0.1"
  end
end

Rack::Attack.safelist("localhost") { |req| req.localhost? }

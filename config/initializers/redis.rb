require 'redis'

if Rails.env.production?
  uri = URI.parse(ENV["REDIS_URL"])
  Redis.current = Redis.new(:url => uri)
else
  Redis.current = Redis.new(:host => 'localhost', :port => 6379)
end

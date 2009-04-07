require File.dirname(__FILE__) + '/../config/environment.rb'

FLICKR = Flickr.new(GlobalConfig.flickr_cache, GlobalConfig.flickr_key, GlobalConfig.flickr_secret)

unless FLICKR.auth.token
  frob = FLICKR.auth.getFrob
  link = FLICKR.auth.login_link
  puts
  puts link
  puts
  puts "copy and paste the above url into your browser then hit enter after viewing the page"
  gets
  FLICKR.auth.getToken(frob)
  FLICKR.auth.cache_token
end
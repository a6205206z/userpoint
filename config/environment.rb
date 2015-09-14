# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

$WEIXIN_API_TICKET = ''
$WEIXIN_API_TIMESTAMP = 0
$WEIXIN_API_NONCESTR = ''
$WEIXIN_API_CACHE_TIME = Time.mktime(1900) 

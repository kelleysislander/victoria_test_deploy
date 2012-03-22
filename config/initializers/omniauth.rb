Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :twitter,    'zz0G4saXLywVqCBnJWGt6g', 'an7sVAUlutlnb1qx5DCtBRZrs61xlNcHXmGsZvCyZ3A' # TestTwiiter account (meghals account)
  # provider :facebook,   '202252433147441', 'e1b6e499120b6fe12df17e98b360fc0c', {:scope => 'publish_stream,offline_access'} # iRival's
  
end

=begin

Consumer key 	zz0G4saXLywVqCBnJWGt6g
Consumer secret 	an7sVAUlutlnb1qx5DCtBRZrs61xlNcHXmGsZvCyZ3A

from twitter after setting up the app to get the keys:

Access level 	Read-only

Consumer key 	zz0G4saXLywVqCBnJWGt6g
Consumer secret 	an7sVAUlutlnb1qx5DCtBRZrs61xlNcHXmGsZvCyZ3A
Request token URL 	https://api.twitter.com/oauth/request_token
Authorize URL 	https://api.twitter.com/oauth/authorize
Access token URL 	https://api.twitter.com/oauth/access_token
Callback URL 	None
=end
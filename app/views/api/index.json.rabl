# 
# { 
#   render :json => 
#   { :splash => {  :url  => splash.url,
#                   :splash_ad_image_url  => @advertisement.image.url,
#                   :auth_token     => current_user.authentication_token}}.to_json
# }

# good one
# object @splash_image_url => :bk

object @splash => :splash
  attribute :url
  attribute :image

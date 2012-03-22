class ApiController < ApplicationController

  prepend_before_filter :get_auth_token
    
  before_filter :authenticate_user!

  # http://localhost:3000/api.json?auth_token=xxF4R2hty51edFpYuepq
  def index
    @splash = Advertisement.find( randomize_splash_ads )
    splash_image = @splash.image_url(:splash)
    @current_user = current_user if current_user      
    if @splash && @current_user
      respond_to do |format|
        format.json { render :json => { :image =>  splash_image, :auth_token => @current_user.authentication_token }, :callback => params[:callback] }.to_json
      end
    else
      respond_to do |format|
        format.json { render :json => {  :image => "ERROR: splash ad not found", :auth_token => "ERROR: No auth_token"}}.to_json
      end
    end
  end
  
  # def show
  # end
  
  # *************************************************************************************
  # custom routes
  # http://localhost:3000/api/auth_test.json?auth_token=W52vyJ26pB1YzcF4EhvK
  # http://victoria.semaphoremobile.com/api/auth_test.json?auth_token=PZYyKiSyGpdxxowcptYR
  # response: {"header":{"auth_token":"4e03a90aaf1f9807d600004a","email":"test@test.com"}}
  # staging: superadmin@semaphoremobile.com        | PZYyKiSyGpdxxowcptYR
  # ************************************************************************************
  
  # result = DeviceRedemption.redemption_valid( "G", "guid-1", 1 )
  # http://localhost:3000/api/redeem.json?auth_token=xxF4R2hty51edFpYuepq&redemption_type=G&device_uid=guid-1&deal_id=1
  # http://localhost:3000/api/redeem.json?auth_token=xxF4R2hty51edFpYuepq&redemption_type=S&device_uid=guid-1&deal_id=1
  def redeem
      result = DeviceRedemption.redemption_valid( params[:redemption_type], params[:device_uid], params[:deal_id] )
      if result[:result]
        DeviceRedemption.create!( :device_uid => params[:device_uid], :deal_id => params[:deal_id], :redemption_type => params[:redemption_type], :redemption_date => Date.today )
        Deal.update_all( { :num_available => result[:new_num_available], :num_redeemed => result[:new_num_redeemed] }, [ "id = ?", params[:deal_id] ] )
      end
    respond_to do |format|
      format.json { render :json => result, :callback => params[:callback] }.to_json
    end
  end
# TODO test redeem
=begin
A. Initial redemption for this device on deal_id = 1
localhost:3000/api/redeem.json?auth_token=xxF4R2hty51edFpYuepq&redemption_type=G&device_uid=guid-1&deal_id=1
{"result":true,"message":"Success: Can Redeem => there are 99 Deals remaining","new_num_available":99,"new_num_redeemed":1}
B.  Try the same one again:
localhost:3000/api/redeem.json?auth_token=xxF4R2hty51edFpYuepq&redemption_type=G&device_uid=guid-1&deal_id=1
{"result":false,"message":"ERROR: Redemption for '99% off Select Items' already done"}
C.  Now an 'S' redemption
localhost:3000/api/redeem.json?auth_token=xxF4R2hty51edFpYuepq&redemption_type=S&device_uid=guid-1&deal_id=1
{"result":true,"message":"Success: First Social Discount Redemption => there are 98 Deals remaining","new_num_available":98,"new_num_redeemed":2}
C.  Current date 03/09/2012 so now we set the "GetIt" redemption_type date back
  a. redemption_date set to 03/08/2012: update device_redemptions set redemption_date = '2012-03-08' where device_uid = 'guid-1' AND redemption_type = 'G';
    localhost:3000/api/redeem.json?auth_token=xxF4R2hty51edFpYuepq&redemption_type=G&device_uid=guid-1&deal_id=1
    {"result":false,"message":"ERROR: Redemption for '99% off Select Items' already done"}
D.  Current date 03/09/2012 so now we set the "GetIt" redemption_type date back to test the "social_discount_interval" for type "S" redemptions
  a. redemption_date set to 03/08/2012: update device_redemptions set redemption_date = '2012-03-08' where device_uid = 'guid-1' AND redemption_type = 'S';
    localhost:3000/api/redeem.json?auth_token=xxF4R2hty51edFpYuepq&redemption_type=S&device_uid=guid-1&deal_id=1
    {"result":false,"message":"ERROR: Cannot redeem again until 2012-03-13"}
E. Current date 03/09/2012 so we now set the redemption_date for a the "S" redemption_type to 03/04/2012 which is 5 days in the past:
  a. redemption_date set to 03/04/2012: update device_redemptions set redemption_date = '2012-03-04' where device_uid = 'guid-1' AND redemption_type = 'S';
  localhost:3000/api/redeem.json?auth_token=xxF4R2hty51edFpYuepq&redemption_type=S&device_uid=guid-1&deal_id=1
  {"result":true,"message":"Success: Can Redeem Additional Social Discount Redemption => there are 97 Deals remaining","new_num_available":97,"new_num_redeemed":3}
=end

  def map_with_deals_and_alerts
    # called as maps#index
  end
  
  # http://localhost:3000/api/deals_with_ads.json?auth_token=xxF4R2hty51edFpYuepq
  # OR
  # http://localhost:3000/api/deals_with_ads?auth_token=xxF4R2hty51edFpYuepq&current_coords=14.624795,-90.532818
  def deals_with_ads
    current_coords = params[:current_coords].split(",").collect { |i| i.to_f } if params[:current_coords]
    @deals_with_ads = Deal.deals_with_ads( current_coords ||= Victoria::Application::GT_Coords )
    respond_to do |format|
      format.json { render :json => @deals_with_ads, :callback => params[:callback] }.to_json
      format.html
    end
  end
  
  # http://localhost:3000/api/deals_only.json?auth_token=rxvEQ2ZGP8CLSNqiaQEM
  # OR
  # http://localhost:3000/api/deals_only?auth_token=rxvEQ2ZGP8CLSNqiaQEM&current_coords=14.624795,-90.532818
  def deals_only
    current_coords = params[:current_coords].split(",").collect { |i| i.to_f } if params[:current_coords]
    @deals_only = Deal.deals_only( current_coords ||= Victoria::Application::GT_Coords )
    respond_to do |format|
      format.json { render :json => { :deals_only => @deals_only, :callback => params[:callback] }}.to_json
      format.html
    end
  end
  
  # http://localhost:3000/api/traffic_alerts.json?auth_token=rxvEQ2ZGP8CLSNqiaQEM
  # http://localhost:3000/api/traffic_alerts?auth_token=rxvEQ2ZGP8CLSNqiaQEM
  def traffic_alerts
    @traffic_alerts = TrafficCondition.current_conditions( Map::TZ_Offset )
    respond_to do |format|
      format.json { render :json =>  @traffic_alerts, :callback => params[:callback] }.to_json
      # format.json { render :json => { :traffic_alerts => @traffic_alerts, :callback => params[:callback] }}.to_json
      format.html
    end
  end
  
  # http://localhost:3000/api/traffic_alerts_with_ads.json?auth_token=rxvEQ2ZGP8CLSNqiaQEM
  # OR
  # http://localhost:3000/api/traffic_alerts_with_ads.json?auth_token=rxvEQ2ZGP8CLSNqiaQEM&current_coords=14.624795,-90.532818
  def traffic_alerts_with_ads
    # patterned after "deals_with_ads" and using traffic_alerts data
    current_coords = params[:current_coords].split(",").collect { |i| i.to_f } if params[:current_coords]
    @traffic_alerts_with_ads = TrafficCondition.traffic_alerts_with_ads( current_coords ||= Victoria::Application::GT_Coords )
    respond_to do |format|
      format.json { render :json => @traffic_alerts_with_ads, :callback => params[:callback] }.to_json
      format.html
    end
  end
  
  # **************************************** User-based custom routes ********************************
  
  # remote_signin_sports GET    /sports/remote_signin(.:format)           {:action=>"remote_signin", :controller=>"sports"}
  # curl -X GET -v -d 'user={ "email" : "mobile@miinfo.com.gt", "password" : "please"}' http://localhost:3000/api/remote_signin.json
  def remote_signin # returns the user's "authentication_token" (ie. in the event the iPhone is lost, the app is uninstalled then reinstalled)
    respond_to do |format|
      format.json { 
        data = ActiveSupport::JSON.decode(params[:user])
        user = User.where(:email => data['email']).first
        if user
          if user.valid_password?( data['password'] )
            message     = "Valid User"
            auth_token  = user.authentication_token
          else
            message     = "ERROR: Invalid User or Password!"
            auth_token  = "na"
          end
        else # if user
          message     = "Invalid User or Password!"
          auth_token  = "na"
          
        end
        render :json => 
        { :user => {  :message      => message,
                      :auth_token   => auth_token}}.to_json
      }
    end
  end
  
  def get_auth_token
    if auth_token = params[:auth_token].blank? && request.headers["X-AUTH-TOKEN"]
      params[:auth_token] = auth_token
    end
  end

  def auth_test
    respond_to do |format|
      format.json { 
        if current_user
          email = current_user.email
          signed_in = signed_in?
        else
          email = "no current_user"
          signed_in = false
        end
        render :json => 
        { :header => { :auth_token    => params[:auth_token],
                       :email         => email,
                       :signed_in     => signed_in}}.to_json
        }
    end
  end
  

  private
  
  def randomize_splash_ads
    ids = Advertisement.active.splash.map { |x| x.id }
    if ids.size > 0
      ids[ rand(ids.size) ]
    else
      Advertisement.splash.limit(1).first.id
    end
  end
  
  def randomize_fullscreen_ads
    ids = Advertisement.active.fullscreen.map { |x| x.id }
    if ids.size > 0
      ids[ rand(ids.size) ]
    else
      Advertisement.fullscreen.limit(1).first.id
    end
  end

end

=begin
staging as of 02/08/2012
+---------------------------------------+----------------------+
| email                                 | authentication_token |  Staging
+---------------------------------------+----------------------+
| superadmin@semaphoremobile.com        | PZYyKiSyGpdxxowcptYR | fPsbBGPQ8EsKxXz8C4x3
| admin@semaphoremobile.com             | 1c6oJxoazFvmpGefGMA9 |
| deal@semaphoremobile.com              | AKydjGERJ52VLK1syws7 |
| advertisement@semaphoremobile.com     | mwxjeryt9ZqcQCbRxzds |
| retailer@semaphoremobile.com          | qFoiwXHxCt4K42sNrneB |
| advertiser@semaphoremobile.com        | qqqoy8HHRcpUzs4XpcFa |
| traffic1@semaphoremobile.com          | 9NquM9JbubqiXhyRpX8Y |
| traffic2@semaphoremobile.com          | wrmQpyqg98jQxzzUsexw |
| kohlsredemption@kohls.com             | nzyQyTqm8uzWHXsACaYt |
| radioshackredemption@radioshack.com   | g6ygychk6hszKyxpzKb6 |
| searsredemption@sears.com             | DvxkZdL8Qh8p6dgqpqzU |
| bkdk1redemption@sbcglobal.net         | uDGzMSpYbvPmpAR5s1g2 |
| bkdk2redemption@sbcglobal.net         | Pe6ZjwFhxpMW2HsCXUtV |
| hpbooksredemption@hpbooks.com         | Axhhxsemf9tu4zpqngFh |
| scubakingredemption@scubaking.com     | bvfWqvzcnsS2dmCopdQV |
| walgreensredemptionr@walgreens.com    | qtf5WsfPPrht9x5uZ7Mq |
| homedepotredemption@homedepot.com     | AjbPab2RV9evizqsKC1p |
| herbsredemption@herbspaintandbody.com | NLm42qaG5kTvnSxvTahx |
| frysredemption@outpost.com            | GbypuqpG4QJZxKEJ5Uqy |
+---------------------------------------+----------------------+

# remote_signup_sports POST   /sports/remote_signup(.:format)           {:action=>"remote_signup", :controller=>"sports"}
# curl -X POST -v -d 'user={ "email" : "bill@bill.com", "password" : "bob123", "password_confirmation" : "bob123"}' http://localhost:3000/sports/remote_signup.json
# data = ActiveSupport::JSON.decode(params[:user])

def remote_signup # creates the new User as role "mobile" and returns the "auth_token" which is tacked onto all remote API calls as authentication
  begin
    data = ActiveSupport::JSON.decode(params[:user])
    check_user = User.where(:email => data['email']).first
    if check_user
      message     = "ERROR: User #{data['email']} already exists"
      auth_token  = check_user.authentication_token
    else
      user = User.new(data)
      user.set_roles_mask( "mobile" )
      if user.save!
        message     = "New User #{user.email} Successfully Created"
        auth_token  = user.authentication_token
        user.save # needed to trip the User.rb "after_save filter to actually save the authentication_token"
      else
        message     = "ERROR: New User NOT created"
        auth_token  = "na"
      end
    end # if check_user
  
    respond_to do |format|
      format.json { 
        render :json => 
        { :user => {  :message       => message,
                      :auth_token    => auth_token}}.to_json
      }
    end

  rescue Exception => e
    
    respond_to do |format|
      format.json { 
        render :json => 
        { :error => { :exception => e.to_s,
                      :backtrace => e.backtrace }}.to_json
      }
    end    
  end # rescue Exception => err_msg
end

# xyz@semaphoremobile.com:
# curl -X POST -v -d 'auth={ "email" : "xyz@semaphoremobile.com", "password" : "abc123", "provider" : "twitter", "uid" : "50070020"}' http://localhost:3000/sports/auth_new_user.json => new user / existing auth
# curl -X POST -v -d 'auth={ "email" : "abc@semaphoremobile.com", "password" : "abc123", "provider" : "twitter", "uid" : "1239866"}' http://localhost:3000/sports/auth_new_user.json => new user / new auth
# curl -X POST -v -d 'auth={ "email" : "xyz@semaphoremobile.com", "password" : "abc123", "provider" : "twitter", "uid" : "50070020"}' http://localhost:3000/sports/auth_new_user.json => existing user / existing user_auth
def auth_new_user # If no miinfo user exists, the mobile user clicks on the twitter/FB icon, logs in there, the mobile app collects the response, then presents the user with a form to get email, password, and password_confirmation
  message = ""
  data = ActiveSupport::JSON.decode(params[:auth])
  user = User.where(:email => data['email']).first
  if user
    message = "ERROR: User #{data['email']} already exists"
    auth_token = "na"
  else # we can create the new User, followed by the Authentication
    user = User.new(:email => data['email'], :password => data['password'])
    if user.save
      message     = "SUCCESS: New User #{user.email} Successfully Created..."
      auth_token  = user.authentication_token
      user.save # needed to trip the User.rb "after_save filter to actually save the authentication_token"
      # now create the Authentication for the new User
      auths = Authentication.where(:provider => data['provider'], :uid => data['uid']).first
      if auths # there is an exsiting authentication, alert the new user
        message += "ALERT: There is already an Authentication for #{data['provider']}: #{data['uid']}..."
      # # else # if user_auths.size > 0
      end
      authentication = user.authentications.create!(:provider => data['provider'], :uid => data['uid'])
      message += "SUCCESS: #{data['provider']} authentication #{data['uid']} successfully created"
      # authentication = user.authentications.create!(:provider => data['provider'], :uid => data['uid'])
      # message += "#{data['provider']} authentication #{data['uid']} successfully created"
    else
      message     = "ERROR: New User NOT created"
      auth_token  = "na"
    end
  end # if user
  respond_to do |format|
    format.json {
      render :json => 
      { :auth => {  :message    => message,
                    :auth_token => auth_token}}.to_json
  } # format.json
  end # respond_to do |format|
end

# curl -X POST -v -d 'auth={ "provider" : "twitter", "uid" : "50070020"}' http://localhost:3000/sports/auth_existing_user.json?auth_token=4e08d22baf1f9802d5000011 => existing user / existing auth
# curl -X POST -v -d 'auth={ "provider" : "twitter", "uid" : "12345609"}' http://localhost:3000/sports/auth_existing_user.json?auth_token=4e08d22baf1f9802d5000011 => existing user / new auth
# curl -X POST -v -d 'auth={ "provider" : "twitter", "uid" : "12345609"}' http://localhost:3000/sports/auth_existing_user.json?auth_token=4e08d22baf1f9802d5000011a => new user / new auth
def auth_existing_user # mobile device sends Twitter / FB "provider" and "uid" back to the server along with the auth_token for that user so we can create the Authentication that is associated with that User
  message = ""
  data = ActiveSupport::JSON.decode(params[:auth])
  if current_user # the existence of a valid "auth_token" automatically gets us a Devise instance of "current_user".  If not then the auth_token is incorrect and does not get a User
    auth_token = current_user.authentication_token
    # check if the proposed authentication already exists
    user_auths = current_user.authentications.where(:provider => data['provider'], :uid => data['uid']).first
    if user_auths # user has exsiting authentication(s), check that the new one is not already on file
      message = "ERROR: #{current_user.email} already has an Authentication for #{data['provider']}: #{data['uid']}\n"
    else # if user_auths
      authentication = current_user.authentications.create!(:provider => data['provider'], :uid => data['uid'])
      message = "SUCCESS: #{current_user.email} #{data['provider']} authentication #{data['uid']} successfully created"
    end
  else # if current_user
    message += "ERROR: The is no User with auth_token: #{params['auth_token']}, User Authentication for #{data['provider']} NOT created"
    auth_token = "na"
  end # if current_user
  
  respond_to do |format|
    format.json { 
      render :json => 
      { :auth => {  :message    => message,
                    :auth_token => auth_token}}.to_json
    } # format.json
  end # respond_to do |format|
end


=end
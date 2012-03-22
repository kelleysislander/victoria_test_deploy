class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  # NOTE: This is the place where control is given after the user authenticates with an external service
  def create
    begin
     #render :text => request.env["omniauth.auth"].to_json
     omniauth = request.env["omniauth.auth"]
     authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
     
     # User IS signed in, has not previously authenticated with a service, but has just now authenticated with a service
      if current_user && !authentication && omniauth['provider']
        # current_user.authentications.find_or_create_by(:provider => omniauth['provider'], :uid => omniauth['uid'])
        current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'], :secret => omniauth['credentials']['secret'])
        # access_token = prepare_access_token(omniauth['credentials']['token'],  omniauth['credentials']['secret'])
        # @response = access_token.request(:post, "http://api.twitter.com/1/statuses/update.json", :status => "I started using iRival App")
        # flash[:notice] = "#{omniauth['credentials']['token']} #{omniauth['credentials']['token']}  omniauth['uid']"
        
        flash[:notice] = "#{omniauth['provider']} authentication successful for #{current_user.email}"
        redirect_to authentications_url
      end

      # User IS NOT signed in, has not previously authenticated with a service, but has just now authenticated with a service
      if !current_user && !authentication && omniauth['provider']
        session[:omniauth] = omniauth.except('extra')
        # flash[:notice] = "redirect_to new_user_registration_url #{session[:omniauth]}"
        flash[:notice] = "#{session[:omniauth]['provider']} authentication successful: Please Sign In to your User Account and click the #{session[:omniauth]['provider']} button to store the authentication."
        redirect_to user_session_path # log in screen
        # end
      end

      # User has previously authenticated with a service, has just logged into their authenticated service, and been returned here to be signed in
      if authentication
        flash[:notice] = "#{authentication.user.email} signed in successfully via #{omniauth['provider']}."
        sign_in_and_redirect(:user, authentication.user)
      end

    rescue Exception => e
      render :text => "<html><body><pre>" + e.to_s + "</pre><hr /><pre>" + e.backtrace.join("\n") + "</pre></body></html>"
    end
  end

  # def create
  #   begin
  #     # render :text => request.env["omniauth.auth"].to_json
  # 
  #     omniauth = request.env["omniauth.auth"]
  #     # current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
  #     current_user.authentications.create!(
  #       :provider => omniauth['provider'], 
  #       :uid      => omniauth['uid'], 
  #       :token    => omniauth['credentials']['token'], 
  #       :secret   => omniauth['credentials']['secret'])
  #   
  #       # NOTE:  Was choking with these 2 attributes, works fine without them
  #   # 
  #     flash[:notice] = "#{omniauth['provider']} authentication successful for #{current_user.email}"
  #     redirect_to authentications_url
  #   rescue Exception => e
  #      # Just spit out the error message and a backtrace.
  #      render :text => "<html><body><pre>" + e.to_s + "</pre><hr /><pre>" + e.backtrace.join("\n") + "</pre></body></html>"  
  #    end
  #  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end

=begin
Problem:

had to set the twitter callback url when setting up the twitter app for omniauth
google search string: "twitter callback url for development" got this:

http://stackoverflow.com/questions/800827/twitter-oauth-callbackurl-localhost-development:
The only solution for now is to create two OAuth applications - one for production and one for development. 
In the development application you set your localhost callback URL instead of the live one.

In the case here, we used "http://127.0.0.1:3000" as the callback URL for the "TestTwiiter" account, then it worked on the dev box.

This happened to me earlier. Make sure your Callback URL is set
properly. Application Type should be "Browser" and the Callback URL
should be "http://yoururl.com/auth/twitter/callback"

result of render :text => request.env["omniauth.auth"]:
{
  "provider": "twitter", 
  "uid": "50070020", 
  "info": {
    "nickname": "kelleysislander", 
    "name": "Bill Kiskin", 
    "location": null, 
    "image": "http://a3.twimg.com/sticky/default_profile_images/default_profile_0_normal.png", 
    "description": null, 
    "urls": {
      "Website": null, 
      "Twitter": "http://twitter.com/kelleysislander"
    }
  }, 
  "credentials": {
    "token": "50070020-A1DrCnc8COrpd18PDpzifMOAbjeQuTeLg1Cpc7tMk", 
    "secret": "cgbyokZyEyxyFaVY4DeYRqBmTEJqHTypwe2FjKpWw"
  }, 
  "extra": {
    "access_token": {
      "token": "50070020-A1DrCnc8COrpd18PDpzifMOAbjeQuTeLg1Cpc7tMk", 
      "secret": "cgbyokZyEyxyFaVY4DeYRqBmTEJqHTypwe2FjKpWw", 
      "consumer": {
        "key": "zz0G4saXLywVqCBnJWGt6g", 
        "secret": "an7sVAUlutlnb1qx5DCtBRZrs61xlNcHXmGsZvCyZ3A", 
        "options": {
          "signature_method": "HMAC-SHA1", 
          "request_token_path": "/oauth/request_token", 
          "authorize_path": "/oauth/authorize", 
          "access_token_path": "/oauth/access_token", 
          "proxy": null, 
          "scheme": "header", 
          "http_method": "post", 
          "oauth_version": "1.0", 
          "site": "https://api.twitter.com"
        }, 
        "http": {
          "address": "api.twitter.com", 
          "port": 443, 
          "curr_http_version": "1.1", 
          "no_keepalive_server": false, 
          "close_on_empty_response": false, 
          "socket": null, 
          "started": false, 
          "open_timeout": 30, 
          "read_timeout": 30, 
          "debug_output": null, 
          "use_ssl": true, 
          "ssl_context": {
            "cert": null, 
            "key": null, 
            "client_ca": null, 
            "ca_file": null, 
            "ca_path": null, 
            "timeout": null, 
            "verify_mode": 0, 
            "verify_depth": null, 
            "verify_callback": null, 
            "options": 4095, 
            "cert_store": null, 
            "extra_chain_cert": null, 
            "client_cert_cb": null, 
            "tmp_dh_callback": null, 
            "session_id_context": null, 
            "session_get_cb": null, 
            "session_new_cb": null, 
            "session_remove_cb": null, 
            "servername_cb": null
          }, 
          "enable_post_connection_check": true, 
          "compression": null, 
          "sspi_enabled": false, 
          "ssl_version": null, 
          "key": null, 
          "cert": null, 
          "ca_file": null, 
          "ca_path": null, 
          "cert_store": null, 
          "ciphers": null, 
          "verify_mode": 0, 
          "verify_callback": null, 
          "verify_depth": null, 
          "ssl_timeout": null, 
          "newimpl": true
        }, 
        "http_method": "post", 
        "uri": {
          "scheme": "https", 
          "user": null, 
          "password": null, 
          "host": "api.twitter.com", 
          "port": 443, 
          "path": "", 
          "query": null, 
          "opaque": null, 
          "registry": null, 
          "fragment": null, 
          "parser": null
        }
      }, 
      "params": {
        "oauth_token": "50070020-A1DrCnc8COrpd18PDpzifMOAbjeQuTeLg1Cpc7tMk", 
        "oauth_token_secret": "cgbyokZyEyxyFaVY4DeYRqBmTEJqHTypwe2FjKpWw", 
        "user_id": "50070020", 
        "screen_name": "kelleysislander"
      }, 
      "response": {
        "date": [
          "Fri, 18 Nov 2011 20:12:39 GMT"
        ], 
        "status": [
          "200 OK"
        ], 
        "x-transaction": [
          "8b5e1724ec66feed"
        ], 
        "x-ratelimit-limit": [
          "350"
        ], 
        "etag": [
          "\"a9889ab56e7033161fc878b993363128\""
        ], 
        "x-frame-options": [
          "SAMEORIGIN"
        ], 
        "last-modified": [
          "Fri, 18 Nov 2011 20:12:39 GMT"
        ], 
        "x-ratelimit-remaining": [
          "348"
        ], 
        "x-runtime": [
          "0.04471"
        ], 
        "x-transaction-mask": [
          "a6183ffa5f8ca943ff1b53b5644ef11404ee1901"
        ], 
        "content-type": [
          "application/json; charset=utf-8"
        ], 
        "content-length": [
          "1868"
        ], 
        "pragma": [
          "no-cache"
        ], 
        "x-access-level": [
          "read"
        ], 
        "x-ratelimit-class": [
          "api_identified"
        ], 
        "x-revision": [
          "DEV"
        ], 
        "expires": [
          "Tue, 31 Mar 1981 05:00:00 GMT"
        ], 
        "cache-control": [
          "no-cache, no-store, must-revalidate, pre-check=0, post-check=0"
        ], 
        "x-mid": [
          "3e4f174fe44c5eaf37db05dfd61be1e309d6def4"
        ], 
        "x-ratelimit-reset": [
          "1321649983"
        ], 
        "set-cookie": [
          "k=10.34.99.112.1321647159796445; path=/; expires=Fri, 25-Nov-11 20:12:39 GMT; domain=.twitter.com", 
          "guest_id=v1%3A132164715980132917; domain=.twitter.com; path=/; expires=Mon, 18-Nov-2013 08:12:39 GMT", 
          "lang=en; path=/", 
          "twid=u%3D50070020%7CSTGMVbvvBqWMj%2FMp0eq8ihcrY7g%3D; domain=.twitter.com; path=/", 
          "_twitter_sess=BAh7CjoHdWEwOgxjc3JmX2lkIiUzZDI5YjkwZmQ3NjdkNzkyMTA2YTg1NTI3%250AMzA3M2RhOToPY3JlYXRlZF9hdGwrCAc6T7gzAToHaWQiJWMxZmNlMGU4MDEz%250AMjBkYTIzMjIyZGY5ZGI5NDcwZDJlIgpmbGFzaElDOidBY3Rpb25Db250cm9s%250AbGVyOjpGbGFzaDo6Rmxhc2hIYXNoewAGOgpAdXNlZHsA--89ac8a3c411e48bb7bd89033715c558d6cc157cc; domain=.twitter.com; path=/; HttpOnly"
        ], 
        "vary": [
          "Accept-Encoding"
        ], 
        "server": [
          "tfe"
        ]
      }
    }, 
    "raw_info": {
      "listed_count": 0, 
      "verified": false, 
      "notifications": false, 
      "time_zone": null, 
      "protected": false, 
      "follow_request_sent": false, 
      "profile_sidebar_border_color": "C0DEED", 
      "location": null, 
      "name": "Bill Kiskin", 
      "profile_use_background_image": true, 
      "utc_offset": null, 
      "followers_count": 2, 
      "url": null, 
      "profile_image_url": "http://a3.twimg.com/sticky/default_profile_images/default_profile_0_normal.png", 
      "description": null, 
      "id_str": "50070020", 
      "default_profile_image": true, 
      "statuses_count": 6, 
      "following": false, 
      "friends_count": 1, 
      "profile_text_color": "333333", 
      "profile_background_image_url": "http://a0.twimg.com/images/themes/theme1/bg.png", 
      "status": {
        "place": null, 
        "favorited": false, 
        "possibly_sensitive": false, 
        "retweet_count": 0, 
        "in_reply_to_screen_name": null, 
        "id_str": "135073893953191937", 
        "retweeted": false, 
        "in_reply_to_status_id_str": null, 
        "geo": null, 
        "coordinates": null, 
        "in_reply_to_user_id": null, 
        "in_reply_to_status_id": null, 
        "created_at": "Fri Nov 11 19:18:20 +0000 2011", 
        "in_reply_to_user_id_str": null, 
        "source": "iRival App", 
        "contributors": null, 
        "truncated": false, 
        "id": 135073893953191940, 
        "text": "This is my taunt Buffalo Bills @ Dallas Cowboys on Sunday, Nov 13, 2011 - 01:00PM EST http://t.co/UQIUKETA"
      }, 
      "is_translator": false, 
      "profile_link_color": "0084B4", 
      "default_profile": true, 
      "contributors_enabled": false, 
      "geo_enabled": false, 
      "profile_background_image_url_https": "https://si0.twimg.com/images/themes/theme1/bg.png", 
      "favourites_count": 0, 
      "created_at": "Tue Jun 23 19:14:25 +0000 2009", 
      "profile_background_color": "C0DEED", 
      "screen_name": "kelleysislander", 
      "show_all_inline_media": false, 
      "profile_background_tile": false, 
      "id": 50070020, 
      "lang": "en", 
      "profile_sidebar_fill_color": "DDEEF6", 
      "profile_image_url_https": "https://si0.twimg.com/sticky/default_profile_images/default_profile_0_normal.png"
    }
  }
}
=end
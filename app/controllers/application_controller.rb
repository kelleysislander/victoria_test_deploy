class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  before_filter :check_user
  before_filter :log_mobile_user_event
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  def check_user
    if current_user && current_user.is_mobile?
      if !"maps,api".include?(params[:controller])
        render :text => "Mobile users cannot access this application"
        sign_out current_user
      end
    end
  end
  
  def get_date_time
    Time.now.strftime("%m/%d/%Y - %I:%M:%S%P")
  end

  # Graceful Error Trapping
  if Rails.env != 'development'
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from Exception,                      :with => :rescue_all_exceptions 
  end

  private
  
  # Routing Errors
  def render_404(exception = nil)
    # Rails.logger.info "\n****************************** ERROR ******************************\nRouting Error\n\n"
    render :file => "#{Rails.root}/public/404.html", :layout => false
    # Notifier.appl_err( "Not Found (404)", "ERROR: The page you requested does not exist: #{params['a']}" ).deliver
  end
  

  # All other errors
  def rescue_all_exceptions(exception)
    err_msg = "****************************** ERROR ******************************\n#{exception.message}\n#{exception.backtrace}\n\n"
    # err_msg = "****************************** ERROR ******************************\n#{exception.message}\n#{exception.backtrace.join( "\n" )}\n\n"
    case exception
    when ActiveRecord::RecordNotFound
      # render :text => "The requested data resource was not found", :status => :not_found
      render :file => "#{Rails.root}/public/resource_not_found.html", :layout => false
      # Rails.logger.info( err_msg )
      # Notifier.appl_err( "Resource Not Found", err_msg ).deliver
    when ActionController::UnknownController, ActionController::UnknownAction
      render :file => "#{Rails.root}/public/invalid_request.html", :layout => false
      # render :text => "Invalid Request", :status => :not_found
      # Rails.logger.info( err_msg )
      # Notifier.appl_err( "Invalid Request", err_msg ).deliver
    when ActionController::RoutingError
      nil
    else
      err_msg = "\n****************************** ERROR ******************************\n
        An Error occured while processing a #{request.method} request on #{request.path}\n
        parameters: #{request.parameters.inspect}\n
        #{exception.message}\n#{exception.backtrace.join( "\n" )}\n\n"
      Rails.logger.info( err_msg )
      render :file => "#{Rails.root}/public/exception.html", :layout => false
      # render :text => "An Internal Error has occurred.<br><br>The error has been logged and an email has been sent to the Site Admin.<br><br>We are sorry for the inconvenience.", :status => :internal_server_error
      # Notifier.appl_err( "Internal Error", err_msg ).deliver
    end
  end

  def log_mobile_user_event
    if params && params[:mobile_user_event] && "social_unlock,fb_share,tw_share,retweet,link_fwd".include?( params[:mobile_user_event] )
      MobileUserEvent.create!( :device_uid => params[:device_uid], :user_event => params[:mobile_user_event], :description => params[:description], :user_event_date => DateTime.now ) 
    end
  end

  # http://stackoverflow.com/questions/9283763/how-do-i-use-google-analytics-custom-events-inside-my-rails-controller

end
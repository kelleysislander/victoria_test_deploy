class RegistrationsController < Devise::RegistrationsController 

  def edit
    if current_user
      @authentications = current_user.authentications
    end   
  end

  def create
    super
    
    if session[:omniauth]
      # begin
      if @user.save
        @user.authentications.create!(:provider => session[:omniauth]['provider'], :uid => session[:omniauth]['uid'])
        flash[:notice] = "#{@user.email} authentication via #{session[:omniauth]['provider']} successfully created"
      else
        flash[:notice] = "User '#{@user.email}' was NOT created"
      end
    end
    
    session[:omniauth] = nil unless @user.new_record?
  end

  # def create
  #   build_resource
  #   resource.role = "user"
  # 
  #   if resource.save
  #     if resource.active?
  #       set_flash_message :notice, :signed_up
  #       sign_in_and_redirect(resource_name, resource)
  #     else
  #       set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s
  #       expire_session_data_after_sign_in!
  #       redirect_to after_inactive_sign_up_path_for(resource)
  #     end
  #   else
  #     clean_up_passwords(resource)
  #     render_with_scope :new
  #   end
  # end

  def token
    #@user = User.where(:id => params[:user_id]).first
    #@user.reset_authentication_token!
    redirect_to edit_user_registration_path(@user)
  end

end

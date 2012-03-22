# NOTE: This controller was added strictly to allow the Admin users to create new users rather than the default "devise" method
# via the registrations_controller which allows for self-registration / maintenance only.  In this app we wanted to allow only the
# Admin user the ability to create new users.

class UserController < ApplicationController
  
  layout :choose_layout
  
  before_filter :authenticate_user!

  load_and_authorize_resource
  
  def index
    if current_user.has_role? [:admin, :superadmin]
      # @users = User.where(:id != current_user.id)
      @users = User.order('accounts.name, users.roles_mask ASC, users.email ASC').includes([:account, {:account => :retailers}]).page(params[:page])
    else
      @users = User.where(:id => current_user.id).page(params[:page])
      # @users = User.find_by_sql(["Select * FROM users u WHERE u.id != ? ORDER BY roles_mask DESC, email ASC", current_user.id])
    end
  end
  
  def show
    @user = User.find(params[:id], :include => [:account])
  end
  
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @user }
    end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      @user.errors.add( :account_id, "is required for the 'User' role" ) if params[:user][:roles].first == "user" && params[:user][:account_id].nil?
      if @user.errors.empty? && @user.save
        format.html { flash[:notice] = "Successfully Created User."; redirect_to user_index_path }
      else
        format.html { render :action => 'new' }
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { flash[:notice] = "Successfully updated User."; redirect_to user_index_path }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      respond_to do |format|
        format.html { flash[:notice] = "Successfully deleted User."; redirect_to root_path }
      end
    end
  end
  
  private
  
  def choose_layout    
    if current_user.has_role? [:traffic]
      'traffic'
    else
      'admin'
    end
  end
  
end

# class UsersController < ApplicationController
#   
#   # authorize_resource
#   
#   before_filter :authenticate_user!
#   
#   def index
#     @users = User.all
#     respond_to do |format|
#       format.html # show.html.haml
#       format.json  { render :json => @users }
#     end
#     
#   end
#   
#   def show
#     @user = User.find(params[:id])
#     respond_to do |format|
#       format.html # show.html.haml
#       format.json  { render :json => @user }
#     end
#   end
#   
# =begin  
#   def new
#     @user = User.new
#     respond_to do |format|
#       format.html # new.html.haml
#       format.json  { render :xml => @user }
#     end
#   end
# 
#   def edit
#     @user = User.find params[:id]
#   end
#   
#   def create
#     @user = User.new(params[:user])
#   
#     respond_to do |format|
#       if @user.save
#         format.html { redirect_to(@user, :notice => 'User was successfully created.') }
#         format.json  { render :json => @user, :status => :created, :location => @user }
#       else
#         format.html { render :action => "new" }
#         format.json  { render :json => @user.errors, :status => :unprocessable_entity }
#       end
#     end
#   end
# 
#   def update
#     @user = User.find(params[:id])
#   
#     respond_to do |format|
#       if @user.update_attributes(params[:user])
#         format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
#         format.json  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.json  { render :json => @user.errors, :status => :unprocessable_entity }
#       end
#     end
#   end
# =end
# 
#   def destroy
#     @user = User.find(params[:id])
#     @user.destroy
#   
#     respond_to do |format|
#       format.html { redirect_to(users_url) }
#       format.json  { head :ok }
#     end
#   end
#   
# end

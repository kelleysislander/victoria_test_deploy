class AccountsController < ApplicationController

  layout :choose_layout
    
  authorize_resource

  def index
    if current_user.has_role? [:admin, :superadmin]
      @accounts = Account.order('name').includes(:users, :retailers).page(params[:page]) # .per(10) "paginates_per 10" is set in the model
    else
      @accounts = Account.order('accounts.name desc').includes(:users, :retailers).where("#{current_user.account_id} = accounts.id").page(params[:page])
    end
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(params[:account])
    if @account.save
      redirect_to @account, :notice => "Successfully Created Account."
    else
      render :action => 'new'
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      redirect_to @account, :notice  => "Successfully updated account."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to accounts_url, :notice => "Successfully destroyed account."
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

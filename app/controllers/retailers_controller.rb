class RetailersController < ApplicationController
  
  before_filter :authenticate_user!

  load_and_authorize_resource
  
  def index
    if current_user.has_role?([:retailer,:admin,:superadmin])
      # eager loading
      @retailers = Retailer.order('accounts.name, retailers.name').includes(:deals, :advertisements, :account).page(params[:page]) # .per(10) "paginates_per 10" is set in the model
    elsif current_user.has_role?([:redemption])
      @retailers = Retailer.where("#{current_user.account_id} = retailers.account_id").order('accounts.name, retailers.name').includes(:deals, :advertisements, :account).page(params[:page]) # .per(10) "paginates_per 10" is set in the model
    else
      @retailers = []
    end
    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @retailers }
    end
  end

  # GET /retailers/1
  # GET /retailers/1.json
  def show
    # @retailer = Retailer.find(params[:id], :include => [:deals, :advertisements, :account] )
    respond_to do |format|
      format.html # show.html.erb
      format.json # show.json.rabl
    end
  end

  # GET /retailers/new
  # GET /retailers/new.json
  def new
    # @retailer = Retailer.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @retailer }
    end
  end

  # GET /retailers/1/edit
  def edit
    # @retailer = Retailer.find(params[:id])
  end

  # POST /retailers
  # POST /retailers.json
  def create
    # @retailer = Retailer.new(params[:retailer])
    respond_to do |format|
      if @retailer.save
        format.html { redirect_to @retailer, notice: 'Retailer was successfully created.' }
        format.json { render json: @retailer, status: :created, location: @retailer }
      else
        format.html { render action: "new" }
        format.json { render json: @retailer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /retailers/1
  # PUT /retailers/1.json
  def update
    # @retailer = Retailer.find(params[:id])
    respond_to do |format|
      if @retailer.update_attributes(params[:retailer])
        format.html { redirect_to @retailer, notice: 'Retailer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @retailer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retailers/1
  # DELETE /retailers/1.json
  def destroy
    # @retailer = Retailer.find(params[:id], :include => [:deals] )
    if !@retailer.deals
      @retailer.destroy
    else
      flash[:notice] = "That Retailer cannot be deleted because it has #{@retailer.deals.size} deals"
    end
    respond_to do |format|
      format.html { redirect_to retailers_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def check_coordinates
    
  end
  
end

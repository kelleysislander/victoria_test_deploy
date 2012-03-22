class AdvertisementsController < ApplicationController
  
  before_filter :authenticate_user!

  load_and_authorize_resource
  
  def index
    # if current_user.has_role?([:advertisement])
    #   # chained eager loading
    #   @advertisements = Advertisement.where("#{current_user.account_id} = retailers.account_id").order('beg_date desc, advertisements.name').includes(:advertiser, {:retailer => :account}).page(params[:page]) # .per(10) "paginates_per 10" is set in the model
    if current_user.has_role?([:admin,:superadmin,:advertisement])
      @advertisements = Advertisement.order('beg_date desc, advertisements.name').includes(:advertiser, {:retailer => :account}).page(params[:page]).per(10) # "paginates_per 10" is set in the model
    else
      @advertisements = []
    end
    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @advertisements }
    end
  end

  # GET /advertisements
  # GET /advertisements.json
  # def index
  #   @advertisements = Advertisement.order('beg_date desc, advertisements.name').includes(:advertiser, {:retailer => :account}).page(params[:page]) # .per(10) "paginates_per 10" is set in the model
  #   # .where("#{current_user.account_id} = retailers.account_id")
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @advertisements }
  #   end
  # end

  # GET /advertisements/1
  # GET /advertisements/1.json
  def show
    # @advertisement = Advertisement.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advertisement }
    end
  end

  # GET /advertisements/new
  # GET /advertisements/new.json
  def new
    # @advertisement = Advertisement.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advertisement }
    end
  end

  # GET /advertisements/1/edit
  def edit
    # @advertisement = Advertisement.find(params[:id])
  end

  # POST /advertisements
  # POST /advertisements.json
  def create
    # @advertisement = Advertisement.new(params[:advertisement])
    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully created.' }
        format.json { render json: @advertisement, status: :created, location: @advertisement }
      else
        format.html { render action: "new", notice: 'Advertisement was NOT successfully created.' }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /advertisements/1
  # PUT /advertisements/1.json
  def update
    # @advertisement = Advertisement.find(params[:id])
    respond_to do |format|
      if @advertisement.update_attributes(params[:advertisement])
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertisements/1
  # DELETE /advertisements/1.json
  def destroy
    # @advertisement = Advertisement.find(params[:id])
    @advertisement.destroy
    respond_to do |format|
      format.html { redirect_to advertisements_url }
      format.json { head :ok }
    end
  end
end

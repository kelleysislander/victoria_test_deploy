class AdvertiserTypesController < ApplicationController

  before_filter :authenticate_user!

  authorize_resource

  layout 'admin'

  # GET /advertiser_types
  # GET /advertiser_types.json
  def index
    @advertiser_types = AdvertiserType.order('advertiser_type').page(params[:page]) # .per(10) "paginates_per 10" is set in the model
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @advertiser_types }
    end
  end

  # GET /advertiser_types/1
  # GET /advertiser_types/1.json
  def show
    @advertiser_type = AdvertiserType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advertiser_type }
    end
  end

  # GET /advertiser_types/new
  # GET /advertiser_types/new.json
  def new
    @advertiser_type = AdvertiserType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advertiser_type }
    end
  end

  # GET /advertiser_types/1/edit
  def edit
    @advertiser_type = AdvertiserType.find(params[:id])
  end

  # POST /advertiser_types
  # POST /advertiser_types.json
  def create
    @advertiser_type = AdvertiserType.new(params[:advertiser_type])

    respond_to do |format|
      if @advertiser_type.save
        format.html { redirect_to @advertiser_type, notice: 'Advertiser type was successfully created.' }
        format.json { render json: @advertiser_type, status: :created, location: @advertiser_type }
      else
        format.html { render action: "new" }
        format.json { render json: @advertiser_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /advertiser_types/1
  # PUT /advertiser_types/1.json
  def update
    @advertiser_type = AdvertiserType.find(params[:id])

    respond_to do |format|
      if @advertiser_type.update_attributes(params[:advertiser_type])
        format.html { redirect_to @advertiser_type, notice: 'Advertiser type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @advertiser_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertiser_types/1
  # DELETE /advertiser_types/1.json
  def destroy
    @advertiser_type = AdvertiserType.find(params[:id])
    @advertiser_type.destroy

    respond_to do |format|
      format.html { redirect_to advertiser_types_url }
      format.json { head :ok }
    end
  end
end

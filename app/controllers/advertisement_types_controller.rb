class AdvertisementTypesController < ApplicationController
  
  before_filter :authenticate_user!

  load_and_authorize_resource

  layout 'admin'
  
  # GET /advertisement_types
  # GET /advertisement_types.json
  def index
    if current_user.has_role?([:admin,:superadmin])
      @advertisement_types = AdvertisementType.order('advertisement_type').page(params[:page]) # .per(10) "paginates_per 10" is set in the model
    else
      @advertisement_types = []
    end
    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @advertisement_types }
    end
  end

  # GET /advertisement_types/1
  # GET /advertisement_types/1.json
  def show
    # @advertisement_type = AdvertisementType.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advertisement_type }
    end
  end

  # GET /advertisement_types/new
  # GET /advertisement_types/new.json
  def new
    # @advertisement_type = AdvertisementType.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advertisement_type }
    end
  end

  # GET /advertisement_types/1/edit
  def edit
    # @advertisement_type = AdvertisementType.find(params[:id])
  end

  # POST /advertisement_types
  # POST /advertisement_types.json
  def create
    # @advertisement_type = AdvertisementType.new(params[:advertisement_type])
    respond_to do |format|
      if @advertisement_type.save
        format.html { redirect_to @advertisement_type, notice: 'Advertisement type was successfully created.' }
        format.json { render json: @advertisement_type, status: :created, location: @advertisement_type }
      else
        format.html { render action: "new" }
        format.json { render json: @advertisement_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /advertisement_types/1
  # PUT /advertisement_types/1.json
  def update
    # @advertisement_type = AdvertisementType.find(params[:id])
    respond_to do |format|
      if @advertisement_type.update_attributes(params[:advertisement_type])
        format.html { redirect_to @advertisement_type, notice: 'Advertisement type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @advertisement_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertisement_types/1
  # DELETE /advertisement_types/1.json
  def destroy
    # @advertisement_type = AdvertisementType.find(params[:id])
    @advertisement_type.destroy
    respond_to do |format|
      format.html { redirect_to advertisement_types_url }
      format.json { head :ok }
    end
  end
end

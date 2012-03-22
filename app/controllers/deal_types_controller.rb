class DealTypesController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource

  layout 'admin'
  
  # GET /deal_types
  # GET /deal_types.json
  def index
    if current_user.has_role?([:admin,:superadmin])
      @deal_types = DealType.order('deal_type').page(params[:page]) # .per(10) "paginates_per 10" is set in the model
    else
      @deal_types = []
    end
    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @deal_types }
    end
  end

  # GET /deal_types/1
  # GET /deal_types/1.json
  def show
    # @deal_type = DealType.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deal_type }
    end
  end

  # GET /deal_types/new
  # GET /deal_types/new.json
  def new
    # @deal_type = DealType.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deal_type }
    end
  end

  # GET /deal_types/1/edit
  def edit
    # @deal_type = DealType.find(params[:id])
  end

  # POST /deal_types
  # POST /deal_types.json
  def create
    # @deal_type = DealType.new(params[:deal_type])
    respond_to do |format|
      if @deal_type.save
        format.html { redirect_to @deal_type, notice: 'Deal type was successfully created.' }
        format.json { render json: @deal_type, status: :created, location: @deal_type }
      else
        format.html { render action: "new" }
        format.json { render json: @deal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deal_types/1
  # PUT /deal_types/1.json
  def update
    # @deal_type = DealType.find(params[:id])
    respond_to do |format|
      if @deal_type.update_attributes(params[:deal_type])
        format.html { redirect_to @deal_type, notice: 'Deal type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @deal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deal_types/1
  # DELETE /deal_types/1.json
  def destroy
    # @deal_type = DealType.find(params[:id])
    @deal_type.destroy
    respond_to do |format|
      format.html { redirect_to deal_types_url }
      format.json { head :ok }
    end
  end
end

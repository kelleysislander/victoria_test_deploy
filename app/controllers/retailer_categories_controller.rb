class RetailerCategoriesController < ApplicationController
  
  before_filter :authenticate_user!

  layout 'admin'
  
  load_and_authorize_resource

  # GET /retailer_categories
  # GET /retailer_categories.json
  def index
    if current_user.has_role?([:admin,:superadmin])
      @retailer_categories = RetailerCategory.order('id').page(params[:page]) # .per(10) "paginates_per 10" is set in the model
    else
      @retailer_categories = []
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @retailer_categories }
    end
  end

  # GET /retailer_categories/1
  # GET /retailer_categories/1.json
  def show
    # @retailer_category = RetailerCategory.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @retailer_category }
    end
  end

  # GET /retailer_categories/new
  # GET /retailer_categories/new.json
  def new
    # @retailer_category = RetailerCategory.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @retailer_category }
    end
  end

  # GET /retailer_categories/1/edit
  def edit
    # @retailer_category = RetailerCategory.find(params[:id])
  end

  # POST /retailer_categories
  # POST /retailer_categories.json
  def create
    # @retailer_category = RetailerCategory.new(params[:retailer_category])
    respond_to do |format|
      if @retailer_category.save
        format.html { redirect_to @retailer_category, notice: 'Retailer category was successfully created.' }
        format.json { render json: @retailer_category, status: :created, location: @retailer_category }
      else
        format.html { render action: "new" }
        format.json { render json: @retailer_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /retailer_categories/1
  # PUT /retailer_categories/1.json
  def update
    # @retailer_category = RetailerCategory.find(params[:id])
    respond_to do |format|
      if @retailer_category.update_attributes(params[:retailer_category])
        format.html { redirect_to @retailer_category, notice: 'Retailer category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @retailer_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retailer_categories/1
  # DELETE /retailer_categories/1.json
  def destroy
    # @retailer_category = RetailerCategory.find(params[:id])
    @retailer_category.destroy
    respond_to do |format|
      format.html { redirect_to retailer_categories_url }
      format.json { head :ok }
    end
  end
end

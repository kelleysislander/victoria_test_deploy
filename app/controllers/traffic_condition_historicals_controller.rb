class TrafficConditionHistoricalsController < ApplicationController
  
  before_filter :authenticate_user!

  load_and_authorize_resource

  layout 'traffic'
  
  def index
    # @traffic_condition_historicals = TrafficConditionHistorical.all
    @traffic_condition_historicals = nil # saves "load_and_authorize_resource" from doing an unnecessary query
    # @traffic_condition_historicals = TrafficConditionHistorical.all
    @cams = TrafficCamera.where(:status => 1).select("DISTINCT(id)")
    @cams.each do |cam|
      # conditions = TrafficCondition.where(:traffic_camera_id => cam.id).includes(:traffic_data_type, :traffic_camera, :traffic_rating, :compass_point).limit(3)
      eval("@cam_#{cam.id} = TrafficConditionHistorical.where(:traffic_camera_id => cam.id).includes( {:traffic_camera => :compass_point}, :traffic_rating ).order('traffic_cameras.id, day_of_week, time_of_day')")   
    end
  end

  def show
    # @traffic_condition_historical = TrafficConditionHistorical.find(params[:id])
  end

  def new
    # @traffic_condition_historical = TrafficConditionHistorical.new
    if params[:traffic_camera_id]
      @traffic_condition_historical.traffic_camera_id = params[:traffic_camera_id] # sent in from "Create" link on "traffic_condition_historicals" index page
    end
    if params[:day_of_week]
      @traffic_condition_historical.day_of_week = params[:day_of_week] # sent in from "Create" link on "traffic_cameras" index page
    end
  end

  def create
    # @traffic_condition_historical = TrafficConditionHistorical.new(params[:traffic_condition_historical])
    if @traffic_condition_historical.save
      redirect_to @traffic_condition_historical, :notice => "Successfully created traffic condition historical."
    else
      if params[:traffic_condition_historical]['traffic_camera_id']
        @traffic_condition_historical.traffic_camera_id = params[:traffic_condition_historical]['traffic_camera_id'] # sent in from "Create" link on "traffic_condtion_historicals" index page
      end
      if params[:traffic_condition_historical]['day_of_week']
        @traffic_condition_historical.traffic_camera_id = params[:traffic_condition_historical]['day_of_week'] # sent in from "Create" link on "traffic_condtion_historicals" index page
      end
      render :action => 'new'
    end

  end

  def edit
    # @traffic_condition_historical = TrafficConditionHistorical.find(params[:id])
  end

  def update
    # @traffic_condition_historical = TrafficConditionHistorical.find(params[:id])
    if @traffic_condition_historical.update_attributes(params[:traffic_condition_historical])
      redirect_to @traffic_condition_historical, :notice  => "Successfully updated traffic condition historical."
    else
      render :action => 'edit'
    end
  end

  def destroy
    # @traffic_condition_historical = TrafficConditionHistorical.find(params[:id])
    @traffic_condition_historical.destroy
    redirect_to traffic_condition_historicals_url, :notice => "Successfully destroyed traffic condition historical."
  end
end

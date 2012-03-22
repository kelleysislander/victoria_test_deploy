class TrafficCamerasController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource

  layout 'traffic'

  def index
    # @traffic_cameras = TrafficCamera.all
    @traffic_cameras = TrafficCamera.where("name != 'Other'").includes(:compass_point).page(params[:page]) 
  end

  def show
    # @traffic_camera = TrafficCamera.find(params[:id])
  end

  def new
    # @traffic_camera = TrafficCamera.new
  end

  def create
    # @traffic_camera = TrafficCamera.new(params[:traffic_camera])
    if @traffic_camera.save
      redirect_to @traffic_camera, :notice => "Successfully created traffic camera."
    else
      render :action => 'new'
    end
  end

  def edit
    # @traffic_camera = TrafficCamera.find(params[:id])
  end

  def update
    # @traffic_camera = TrafficCamera.find(params[:id])
    if @traffic_camera.update_attributes(params[:traffic_camera])
      redirect_to @traffic_camera, :notice  => "Successfully updated traffic camera."
    else
      render :action => 'edit'
    end
  end

  def destroy
    # @traffic_camera = TrafficCamera.find(params[:id])
    @traffic_camera.destroy
    redirect_to traffic_cameras_url, :notice => "Successfully destroyed traffic camera."
  end
end

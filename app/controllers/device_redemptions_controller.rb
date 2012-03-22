class DeviceRedemptionsController < ApplicationController
  
  before_filter :authenticate_user!

  authorize_resource
  
  def index
    @device_redemptions = DeviceRedemption.order("redemption_date desc").includes(:deal).page(params[:page])
  end

  def show
    @device_redemption = DeviceRedemption.find(params[:id])
  end

  def new
    @device_redemption = DeviceRedemption.new
  end

  def create
    @device_redemption = DeviceRedemption.new(params[:device_redemption])
    if @device_redemption.save
      redirect_to @device_redemption, :notice => "Successfully created Device Redemption."
    else
      render :action => 'new'
    end
  end

  def edit
    @device_redemption = DeviceRedemption.find(params[:id])
  end

  def update
    @device_redemption = DeviceRedemption.find(params[:id])
    if @device_redemption.update_attributes(params[:device_redemption])
      redirect_to @device_redemption, :notice  => "Successfully updated device redemption."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @device_redemption = DeviceRedemption.find(params[:id])
    @device_redemption.destroy
    redirect_to device_redemptions_url, :notice => "Successfully destroyed device redemption."
  end
end

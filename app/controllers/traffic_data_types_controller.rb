class TrafficDataTypesController < ApplicationController

  layout 'traffic'

  def index
    @traffic_data_types = TrafficDataType.all
  end

  def show
    @traffic_data_type = TrafficDataType.find(params[:id])
  end

  def new
    @traffic_data_type = TrafficDataType.new
  end

  def create
    @traffic_data_type = TrafficDataType.new(params[:traffic_data_type])
    if @traffic_data_type.save
      redirect_to @traffic_data_type, :notice => "Successfully created traffic data type."
    else
      render :action => 'new'
    end
  end

  def edit
    @traffic_data_type = TrafficDataType.find(params[:id])
  end

  def update
    @traffic_data_type = TrafficDataType.find(params[:id])
    if @traffic_data_type.update_attributes(params[:traffic_data_type])
      redirect_to @traffic_data_type, :notice  => "Successfully updated traffic data type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @traffic_data_type = TrafficDataType.find(params[:id])
    @traffic_data_type.destroy
    redirect_to traffic_data_types_url, :notice => "Successfully destroyed traffic data type."
  end
end

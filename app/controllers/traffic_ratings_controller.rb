class TrafficRatingsController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource

  layout 'traffic'

  def index
    # @traffic_ratings = TrafficRating.all
  end

  def show
    # @traffic_rating = TrafficRating.find(params[:id])
  end

  def new
    # @traffic_rating = TrafficRating.new
  end

  def create
    # @traffic_rating = TrafficRating.new(params[:traffic_rating])
    if @traffic_rating.save
      redirect_to @traffic_rating, :notice => "Successfully created traffic rating."
    else
      render :action => 'new'
    end
  end

  def edit
    # @traffic_rating = TrafficRating.find(params[:id])
  end

  def update
    # @traffic_rating = TrafficRating.find(params[:id])
    if @traffic_rating.update_attributes(params[:traffic_rating])
      redirect_to @traffic_rating, :notice  => "Successfully updated traffic rating."
    else
      render :action => 'edit'
    end
  end

  def destroy
    # @traffic_rating = TrafficRating.find(params[:id])
    @traffic_rating.destroy
    redirect_to traffic_ratings_url, :notice => "Successfully destroyed traffic rating."
  end
end

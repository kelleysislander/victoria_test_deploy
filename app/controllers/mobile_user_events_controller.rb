class MobileUserEventsController < ApplicationController

  before_filter :authenticate_user!

  authorize_resource

  def index
    @mobile_user_events = MobileUserEvent.all
  end

  def show
    @mobile_user_event = MobileUserEvent.find(params[:id])
  end

  def destroy
    @mobile_user_event = MobileUserEvent.find(params[:id])
    @mobile_user_event.destroy
    redirect_to mobile_user_events_url, :notice => "Successfully destroyed mobile user event."
  end

end

=begin
  def new
    @mobile_user_event = MobileUserEvent.new
  end

  def create
    @mobile_user_event = MobileUserEvent.new(params[:mobile_user_event])
    if @mobile_user_event.save
      redirect_to @mobile_user_event, :notice => "Successfully created mobile user event."
    else
      render :action => 'new'
    end
  end

  def edit
    @mobile_user_event = MobileUserEvent.find(params[:id])
  end

  def update
    @mobile_user_event = MobileUserEvent.find(params[:id])
    if @mobile_user_event.update_attributes(params[:mobile_user_event])
      redirect_to @mobile_user_event, :notice  => "Successfully updated mobile user event."
    else
      render :action => 'edit'
    end
  end
=end

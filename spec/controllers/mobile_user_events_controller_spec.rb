require File.dirname(__FILE__) + '/../spec_helper'

describe MobileUserEventsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => MobileUserEvent.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    MobileUserEvent.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    MobileUserEvent.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(mobile_user_event_url(assigns[:mobile_user_event]))
  end

  it "edit action should render edit template" do
    get :edit, :id => MobileUserEvent.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    MobileUserEvent.any_instance.stubs(:valid?).returns(false)
    put :update, :id => MobileUserEvent.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    MobileUserEvent.any_instance.stubs(:valid?).returns(true)
    put :update, :id => MobileUserEvent.first
    response.should redirect_to(mobile_user_event_url(assigns[:mobile_user_event]))
  end

  it "destroy action should destroy model and redirect to index action" do
    mobile_user_event = MobileUserEvent.first
    delete :destroy, :id => mobile_user_event
    response.should redirect_to(mobile_user_events_url)
    MobileUserEvent.exists?(mobile_user_event.id).should be_false
  end
end

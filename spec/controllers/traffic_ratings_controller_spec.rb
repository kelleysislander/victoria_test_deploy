require File.dirname(__FILE__) + '/../spec_helper'

describe TrafficRatingsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => TrafficRating.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    TrafficRating.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    TrafficRating.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(traffic_rating_url(assigns[:traffic_rating]))
  end

  it "edit action should render edit template" do
    get :edit, :id => TrafficRating.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    TrafficRating.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TrafficRating.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    TrafficRating.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TrafficRating.first
    response.should redirect_to(traffic_rating_url(assigns[:traffic_rating]))
  end

  it "destroy action should destroy model and redirect to index action" do
    traffic_rating = TrafficRating.first
    delete :destroy, :id => traffic_rating
    response.should redirect_to(traffic_ratings_url)
    TrafficRating.exists?(traffic_rating.id).should be_false
  end
end

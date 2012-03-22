require File.dirname(__FILE__) + '/../spec_helper'

describe TrafficConditionHistoricalsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => TrafficConditionHistorical.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    TrafficConditionHistorical.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    TrafficConditionHistorical.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(traffic_condition_historical_url(assigns[:traffic_condition_historical]))
  end

  it "edit action should render edit template" do
    get :edit, :id => TrafficConditionHistorical.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    TrafficConditionHistorical.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TrafficConditionHistorical.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    TrafficConditionHistorical.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TrafficConditionHistorical.first
    response.should redirect_to(traffic_condition_historical_url(assigns[:traffic_condition_historical]))
  end

  it "destroy action should destroy model and redirect to index action" do
    traffic_condition_historical = TrafficConditionHistorical.first
    delete :destroy, :id => traffic_condition_historical
    response.should redirect_to(traffic_condition_historicals_url)
    TrafficConditionHistorical.exists?(traffic_condition_historical.id).should be_false
  end
end

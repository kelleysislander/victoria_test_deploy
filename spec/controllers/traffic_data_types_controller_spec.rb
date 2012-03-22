require File.dirname(__FILE__) + '/../spec_helper'

describe TrafficDataTypesController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => TrafficDataType.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    TrafficDataType.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    TrafficDataType.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(traffic_data_type_url(assigns[:traffic_data_type]))
  end

  it "edit action should render edit template" do
    get :edit, :id => TrafficDataType.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    TrafficDataType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TrafficDataType.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    TrafficDataType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TrafficDataType.first
    response.should redirect_to(traffic_data_type_url(assigns[:traffic_data_type]))
  end

  it "destroy action should destroy model and redirect to index action" do
    traffic_data_type = TrafficDataType.first
    delete :destroy, :id => traffic_data_type
    response.should redirect_to(traffic_data_types_url)
    TrafficDataType.exists?(traffic_data_type.id).should be_false
  end
end

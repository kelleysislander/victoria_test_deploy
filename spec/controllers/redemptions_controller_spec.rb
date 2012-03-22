require File.dirname(__FILE__) + '/../spec_helper'

describe RedemptionsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Redemption.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Redemption.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Redemption.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(redemption_url(assigns[:redemption]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Redemption.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Redemption.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Redemption.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Redemption.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Redemption.first
    response.should redirect_to(redemption_url(assigns[:redemption]))
  end

  it "destroy action should destroy model and redirect to index action" do
    redemption = Redemption.first
    delete :destroy, :id => redemption
    response.should redirect_to(redemptions_url)
    Redemption.exists?(redemption.id).should be_false
  end
end

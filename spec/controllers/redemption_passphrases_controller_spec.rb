require File.dirname(__FILE__) + '/../spec_helper'

describe RedemptionPassphrasesController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => RedemptionPassphrase.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    RedemptionPassphrase.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    RedemptionPassphrase.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(redemption_passphrase_url(assigns[:redemption_passphrase]))
  end

  it "edit action should render edit template" do
    get :edit, :id => RedemptionPassphrase.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    RedemptionPassphrase.any_instance.stubs(:valid?).returns(false)
    put :update, :id => RedemptionPassphrase.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    RedemptionPassphrase.any_instance.stubs(:valid?).returns(true)
    put :update, :id => RedemptionPassphrase.first
    response.should redirect_to(redemption_passphrase_url(assigns[:redemption_passphrase]))
  end

  it "destroy action should destroy model and redirect to index action" do
    redemption_passphrase = RedemptionPassphrase.first
    delete :destroy, :id => redemption_passphrase
    response.should redirect_to(redemption_passphrases_url)
    RedemptionPassphrase.exists?(redemption_passphrase.id).should be_false
  end
end

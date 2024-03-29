require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AdvertisementsController do

  # This should return the minimal set of attributes required to create a valid
  # Advertisement. As you add validations to Advertisement, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all advertisements as @advertisements" do
      advertisement = Advertisement.create! valid_attributes
      get :index
      assigns(:advertisements).should eq([advertisement])
    end
  end

  describe "GET show" do
    it "assigns the requested advertisement as @advertisement" do
      advertisement = Advertisement.create! valid_attributes
      get :show, :id => advertisement.id
      assigns(:advertisement).should eq(advertisement)
    end
  end

  describe "GET new" do
    it "assigns a new advertisement as @advertisement" do
      get :new
      assigns(:advertisement).should be_a_new(Advertisement)
    end
  end

  describe "GET edit" do
    it "assigns the requested advertisement as @advertisement" do
      advertisement = Advertisement.create! valid_attributes
      get :edit, :id => advertisement.id
      assigns(:advertisement).should eq(advertisement)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Advertisement" do
        expect {
          post :create, :advertisement => valid_attributes
        }.to change(Advertisement, :count).by(1)
      end

      it "assigns a newly created advertisement as @advertisement" do
        post :create, :advertisement => valid_attributes
        assigns(:advertisement).should be_a(Advertisement)
        assigns(:advertisement).should be_persisted
      end

      it "redirects to the created advertisement" do
        post :create, :advertisement => valid_attributes
        response.should redirect_to(Advertisement.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved advertisement as @advertisement" do
        # Trigger the behavior that occurs when invalid params are submitted
        Advertisement.any_instance.stub(:save).and_return(false)
        post :create, :advertisement => {}
        assigns(:advertisement).should be_a_new(Advertisement)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Advertisement.any_instance.stub(:save).and_return(false)
        post :create, :advertisement => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested advertisement" do
        advertisement = Advertisement.create! valid_attributes
        # Assuming there are no other advertisements in the database, this
        # specifies that the Advertisement created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Advertisement.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => advertisement.id, :advertisement => {'these' => 'params'}
      end

      it "assigns the requested advertisement as @advertisement" do
        advertisement = Advertisement.create! valid_attributes
        put :update, :id => advertisement.id, :advertisement => valid_attributes
        assigns(:advertisement).should eq(advertisement)
      end

      it "redirects to the advertisement" do
        advertisement = Advertisement.create! valid_attributes
        put :update, :id => advertisement.id, :advertisement => valid_attributes
        response.should redirect_to(advertisement)
      end
    end

    describe "with invalid params" do
      it "assigns the advertisement as @advertisement" do
        advertisement = Advertisement.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Advertisement.any_instance.stub(:save).and_return(false)
        put :update, :id => advertisement.id, :advertisement => {}
        assigns(:advertisement).should eq(advertisement)
      end

      it "re-renders the 'edit' template" do
        advertisement = Advertisement.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Advertisement.any_instance.stub(:save).and_return(false)
        put :update, :id => advertisement.id, :advertisement => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested advertisement" do
      advertisement = Advertisement.create! valid_attributes
      expect {
        delete :destroy, :id => advertisement.id
      }.to change(Advertisement, :count).by(-1)
    end

    it "redirects to the advertisements list" do
      advertisement = Advertisement.create! valid_attributes
      delete :destroy, :id => advertisement.id
      response.should redirect_to(advertisements_url)
    end
  end

end

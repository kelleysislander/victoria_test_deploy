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

describe RetailerCategoriesController do

  # This should return the minimal set of attributes required to create a valid
  # RetailerCategory. As you add validations to RetailerCategory, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all retailer_categories as @retailer_categories" do
      retailer_category = RetailerCategory.create! valid_attributes
      get :index
      assigns(:retailer_categories).should eq([retailer_category])
    end
  end

  describe "GET show" do
    it "assigns the requested retailer_category as @retailer_category" do
      retailer_category = RetailerCategory.create! valid_attributes
      get :show, :id => retailer_category.id
      assigns(:retailer_category).should eq(retailer_category)
    end
  end

  describe "GET new" do
    it "assigns a new retailer_category as @retailer_category" do
      get :new
      assigns(:retailer_category).should be_a_new(RetailerCategory)
    end
  end

  describe "GET edit" do
    it "assigns the requested retailer_category as @retailer_category" do
      retailer_category = RetailerCategory.create! valid_attributes
      get :edit, :id => retailer_category.id
      assigns(:retailer_category).should eq(retailer_category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new RetailerCategory" do
        expect {
          post :create, :retailer_category => valid_attributes
        }.to change(RetailerCategory, :count).by(1)
      end

      it "assigns a newly created retailer_category as @retailer_category" do
        post :create, :retailer_category => valid_attributes
        assigns(:retailer_category).should be_a(RetailerCategory)
        assigns(:retailer_category).should be_persisted
      end

      it "redirects to the created retailer_category" do
        post :create, :retailer_category => valid_attributes
        response.should redirect_to(RetailerCategory.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved retailer_category as @retailer_category" do
        # Trigger the behavior that occurs when invalid params are submitted
        RetailerCategory.any_instance.stub(:save).and_return(false)
        post :create, :retailer_category => {}
        assigns(:retailer_category).should be_a_new(RetailerCategory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        RetailerCategory.any_instance.stub(:save).and_return(false)
        post :create, :retailer_category => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested retailer_category" do
        retailer_category = RetailerCategory.create! valid_attributes
        # Assuming there are no other retailer_categories in the database, this
        # specifies that the RetailerCategory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        RetailerCategory.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => retailer_category.id, :retailer_category => {'these' => 'params'}
      end

      it "assigns the requested retailer_category as @retailer_category" do
        retailer_category = RetailerCategory.create! valid_attributes
        put :update, :id => retailer_category.id, :retailer_category => valid_attributes
        assigns(:retailer_category).should eq(retailer_category)
      end

      it "redirects to the retailer_category" do
        retailer_category = RetailerCategory.create! valid_attributes
        put :update, :id => retailer_category.id, :retailer_category => valid_attributes
        response.should redirect_to(retailer_category)
      end
    end

    describe "with invalid params" do
      it "assigns the retailer_category as @retailer_category" do
        retailer_category = RetailerCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RetailerCategory.any_instance.stub(:save).and_return(false)
        put :update, :id => retailer_category.id, :retailer_category => {}
        assigns(:retailer_category).should eq(retailer_category)
      end

      it "re-renders the 'edit' template" do
        retailer_category = RetailerCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RetailerCategory.any_instance.stub(:save).and_return(false)
        put :update, :id => retailer_category.id, :retailer_category => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested retailer_category" do
      retailer_category = RetailerCategory.create! valid_attributes
      expect {
        delete :destroy, :id => retailer_category.id
      }.to change(RetailerCategory, :count).by(-1)
    end

    it "redirects to the retailer_categories list" do
      retailer_category = RetailerCategory.create! valid_attributes
      delete :destroy, :id => retailer_category.id
      response.should redirect_to(retailer_categories_url)
    end
  end

end

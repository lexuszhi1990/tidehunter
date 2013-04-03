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

describe TravelsController do

  # This should return the minimal set of attributes required to create a valid
  # Travel. As you add validations to Travel, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "place" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TravelsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all travels as @travels" do
      travel = Travel.create! valid_attributes
      get :index, {}, valid_session
      assigns(:travels).should eq([travel])
    end
  end

  describe "GET show" do
    it "assigns the requested travel as @travel" do
      travel = Travel.create! valid_attributes
      get :show, {:id => travel.to_param}, valid_session
      assigns(:travel).should eq(travel)
    end
  end

  describe "GET new" do
    it "assigns a new travel as @travel" do
      get :new, {}, valid_session
      assigns(:travel).should be_a_new(Travel)
    end
  end

  describe "GET edit" do
    it "assigns the requested travel as @travel" do
      travel = Travel.create! valid_attributes
      get :edit, {:id => travel.to_param}, valid_session
      assigns(:travel).should eq(travel)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Travel" do
        expect {
          post :create, {:travel => valid_attributes}, valid_session
        }.to change(Travel, :count).by(1)
      end

      it "assigns a newly created travel as @travel" do
        post :create, {:travel => valid_attributes}, valid_session
        assigns(:travel).should be_a(Travel)
        assigns(:travel).should be_persisted
      end

      it "redirects to the created travel" do
        post :create, {:travel => valid_attributes}, valid_session
        response.should redirect_to(Travel.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved travel as @travel" do
        # Trigger the behavior that occurs when invalid params are submitted
        Travel.any_instance.stub(:save).and_return(false)
        post :create, {:travel => { "place" => "invalid value" }}, valid_session
        assigns(:travel).should be_a_new(Travel)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Travel.any_instance.stub(:save).and_return(false)
        post :create, {:travel => { "place" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested travel" do
        travel = Travel.create! valid_attributes
        # Assuming there are no other travels in the database, this
        # specifies that the Travel created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Travel.any_instance.should_receive(:update_attributes).with({ "place" => "MyString" })
        put :update, {:id => travel.to_param, :travel => { "place" => "MyString" }}, valid_session
      end

      it "assigns the requested travel as @travel" do
        travel = Travel.create! valid_attributes
        put :update, {:id => travel.to_param, :travel => valid_attributes}, valid_session
        assigns(:travel).should eq(travel)
      end

      it "redirects to the travel" do
        travel = Travel.create! valid_attributes
        put :update, {:id => travel.to_param, :travel => valid_attributes}, valid_session
        response.should redirect_to(travel)
      end
    end

    describe "with invalid params" do
      it "assigns the travel as @travel" do
        travel = Travel.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Travel.any_instance.stub(:save).and_return(false)
        put :update, {:id => travel.to_param, :travel => { "place" => "invalid value" }}, valid_session
        assigns(:travel).should eq(travel)
      end

      it "re-renders the 'edit' template" do
        travel = Travel.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Travel.any_instance.stub(:save).and_return(false)
        put :update, {:id => travel.to_param, :travel => { "place" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested travel" do
      travel = Travel.create! valid_attributes
      expect {
        delete :destroy, {:id => travel.to_param}, valid_session
      }.to change(Travel, :count).by(-1)
    end

    it "redirects to the travels list" do
      travel = Travel.create! valid_attributes
      delete :destroy, {:id => travel.to_param}, valid_session
      response.should redirect_to(travels_url)
    end
  end

end

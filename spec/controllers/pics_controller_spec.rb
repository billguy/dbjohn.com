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

describe PicsController do

  # This should return the minimal set of attributes required to create a valid
  # Pic. As you add validations to Pic, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "published" => "false" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PicsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all pics as @pics" do
      pic = Pic.create! valid_attributes
      get :index, {}, valid_session
      assigns(:pics).should eq([pic])
    end
  end

  describe "GET show" do
    it "assigns the requested pic as @pic" do
      pic = Pic.create! valid_attributes
      get :show, {:id => pic.to_param}, valid_session
      assigns(:pic).should eq(pic)
    end
  end

  describe "GET new" do
    it "assigns a new pic as @pic" do
      get :new, {}, valid_session
      assigns(:pic).should be_a_new(Pic)
    end
  end

  describe "GET edit" do
    it "assigns the requested pic as @pic" do
      pic = Pic.create! valid_attributes
      get :edit, {:id => pic.to_param}, valid_session
      assigns(:pic).should eq(pic)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Pic" do
        expect {
          post :create, {:pic => valid_attributes}, valid_session
        }.to change(Pic, :count).by(1)
      end

      it "assigns a newly created pic as @pic" do
        post :create, {:pic => valid_attributes}, valid_session
        assigns(:pic).should be_a(Pic)
        assigns(:pic).should be_persisted
      end

      it "redirects to the created pic" do
        post :create, {:pic => valid_attributes}, valid_session
        response.should redirect_to(Pic.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pic as @pic" do
        # Trigger the behavior that occurs when invalid params are submitted
        Pic.any_instance.stub(:save).and_return(false)
        post :create, {:pic => { "published" => "invalid value" }}, valid_session
        assigns(:pic).should be_a_new(Pic)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Pic.any_instance.stub(:save).and_return(false)
        post :create, {:pic => { "published" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested pic" do
        pic = Pic.create! valid_attributes
        # Assuming there are no other pics in the database, this
        # specifies that the Pic created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Pic.any_instance.should_receive(:update).with({ "published" => "false" })
        put :update, {:id => pic.to_param, :pic => { "published" => "false" }}, valid_session
      end

      it "assigns the requested pic as @pic" do
        pic = Pic.create! valid_attributes
        put :update, {:id => pic.to_param, :pic => valid_attributes}, valid_session
        assigns(:pic).should eq(pic)
      end

      it "redirects to the pic" do
        pic = Pic.create! valid_attributes
        put :update, {:id => pic.to_param, :pic => valid_attributes}, valid_session
        response.should redirect_to(pic)
      end
    end

    describe "with invalid params" do
      it "assigns the pic as @pic" do
        pic = Pic.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Pic.any_instance.stub(:save).and_return(false)
        put :update, {:id => pic.to_param, :pic => { "published" => "invalid value" }}, valid_session
        assigns(:pic).should eq(pic)
      end

      it "re-renders the 'edit' template" do
        pic = Pic.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Pic.any_instance.stub(:save).and_return(false)
        put :update, {:id => pic.to_param, :pic => { "published" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested pic" do
      pic = Pic.create! valid_attributes
      expect {
        delete :destroy, {:id => pic.to_param}, valid_session
      }.to change(Pic, :count).by(-1)
    end

    it "redirects to the pics list" do
      pic = Pic.create! valid_attributes
      delete :destroy, {:id => pic.to_param}, valid_session
      response.should redirect_to(pics_url)
    end
  end

end

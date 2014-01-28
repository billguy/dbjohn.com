require "spec_helper"

describe PicsController do
  describe "routing" do

    it "routes to #index" do
      get("/pics").should route_to("pics#index")
    end

    it "routes to #new" do
      get("/pics/new").should route_to("pics#new")
    end

    it "routes to #show" do
      get("/pics/1").should route_to("pics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pics/1/edit").should route_to("pics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pics").should route_to("pics#create")
    end

    it "routes to #update" do
      put("/pics/1").should route_to("pics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pics/1").should route_to("pics#destroy", :id => "1")
    end

  end
end

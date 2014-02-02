require "spec_helper"

describe SlogansController do
  describe "routing" do

    it "routes to #index" do
      get("/slogans").should route_to("slogans#index")
    end

    it "routes to #new" do
      get("/slogans/new").should route_to("slogans#new")
    end

    it "routes to #show" do
      get("/slogans/1").should route_to("slogans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/slogans/1/edit").should route_to("slogans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/slogans").should route_to("slogans#create")
    end

    it "routes to #update" do
      put("/slogans/1").should route_to("slogans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/slogans/1").should route_to("slogans#destroy", :id => "1")
    end

  end
end

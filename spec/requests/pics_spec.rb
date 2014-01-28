require 'spec_helper'

describe "Pics" do
  describe "GET /pics" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get pics_path
      response.status.should be(200)
    end
  end
end

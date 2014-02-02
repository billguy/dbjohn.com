require 'spec_helper'

describe "slogans/index" do
  before(:each) do
    assign(:slogans, [
      stub_model(Slogan),
      stub_model(Slogan)
    ])
  end

  it "renders a list of slogans" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

require 'spec_helper'

describe "slogans/show" do
  before(:each) do
    @slogan = assign(:slogan, stub_model(Slogan))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

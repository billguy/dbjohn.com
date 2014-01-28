require 'spec_helper'

describe "pics/show" do
  before(:each) do
    @pic = assign(:pic, stub_model(Pic,
      :published => false,
      :title => "Title",
      :attachment => "",
      :caption => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    rendered.should match(/Title/)
    rendered.should match(//)
    rendered.should match(/MyText/)
  end
end

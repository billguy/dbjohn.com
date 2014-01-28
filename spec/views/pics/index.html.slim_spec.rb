require 'spec_helper'

describe "pics/index" do
  before(:each) do
    assign(:pics, [
      stub_model(Pic,
        :published => false,
        :title => "Title",
        :attachment => "",
        :caption => "MyText"
      ),
      stub_model(Pic,
        :published => false,
        :title => "Title",
        :attachment => "",
        :caption => "MyText"
      )
    ])
  end

  it "renders a list of pics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

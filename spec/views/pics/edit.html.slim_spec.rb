require 'spec_helper'

describe "pics/edit" do
  before(:each) do
    @pic = assign(:pic, stub_model(Pic,
      :published => false,
      :title => "MyString",
      :attachment => "",
      :caption => "MyText"
    ))
  end

  it "renders the edit pic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pic_path(@pic), "post" do
      assert_select "input#pic_published[name=?]", "pic[published]"
      assert_select "input#pic_title[name=?]", "pic[title]"
      assert_select "input#pic_attachment[name=?]", "pic[attachment]"
      assert_select "textarea#pic_caption[name=?]", "pic[caption]"
    end
  end
end

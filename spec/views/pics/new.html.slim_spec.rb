require 'spec_helper'

describe "pics/new" do
  before(:each) do
    assign(:pic, stub_model(Pic,
      :published => false,
      :title => "MyString",
      :attachment => "",
      :caption => "MyText"
    ).as_new_record)
  end

  it "renders new pic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pics_path, "post" do
      assert_select "input#pic_published[name=?]", "pic[published]"
      assert_select "input#pic_title[name=?]", "pic[title]"
      assert_select "input#pic_attachment[name=?]", "pic[attachment]"
      assert_select "textarea#pic_caption[name=?]", "pic[caption]"
    end
  end
end

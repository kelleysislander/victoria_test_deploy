require 'spec_helper'

describe "advertisements/new.html.haml" do
  before(:each) do
    assign(:advertisement, stub_model(Advertisement,
      :name => "MyString",
      :description => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new advertisement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => advertisements_path, :method => "post" do
      assert_select "input#advertisement_name", :name => "advertisement[name]"
      assert_select "input#advertisement_description", :name => "advertisement[description]"
      assert_select "textarea#advertisement_content", :name => "advertisement[content]"
    end
  end
end

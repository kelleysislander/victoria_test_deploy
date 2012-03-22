require 'spec_helper'

describe "advertisements/edit.html.haml" do
  before(:each) do
    @advertisement = assign(:advertisement, stub_model(Advertisement,
      :name => "MyString",
      :description => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit advertisement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => advertisements_path(@advertisement), :method => "post" do
      assert_select "input#advertisement_name", :name => "advertisement[name]"
      assert_select "input#advertisement_description", :name => "advertisement[description]"
      assert_select "textarea#advertisement_content", :name => "advertisement[content]"
    end
  end
end

require 'spec_helper'

describe "advertisements/index.html.haml" do
  before(:each) do
    assign(:advertisements, [
      stub_model(Advertisement,
        :name => "Name",
        :description => "Description",
        :content => "MyText"
      ),
      stub_model(Advertisement,
        :name => "Name",
        :description => "Description",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of advertisements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

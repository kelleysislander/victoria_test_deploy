require 'spec_helper'

describe "deal_types/edit.html.haml" do
  before(:each) do
    @deal_type = assign(:deal_type, stub_model(DealType,
      :deal_type => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit deal_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => deal_types_path(@deal_type), :method => "post" do
      assert_select "input#deal_type_deal_type", :name => "deal_type[deal_type]"
      assert_select "input#deal_type_description", :name => "deal_type[description]"
    end
  end
end

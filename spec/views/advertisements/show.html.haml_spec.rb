require 'spec_helper'

describe "advertisements/show.html.haml" do
  before(:each) do
    @advertisement = assign(:advertisement, stub_model(Advertisement,
      :name => "Name",
      :description => "Description",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end

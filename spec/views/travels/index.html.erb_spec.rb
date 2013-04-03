require 'spec_helper'

describe "travels/index" do
  before(:each) do
    assign(:travels, [
      stub_model(Travel,
        :place => "Place",
        :body => "MyText"
      ),
      stub_model(Travel,
        :place => "Place",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of travels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Place".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

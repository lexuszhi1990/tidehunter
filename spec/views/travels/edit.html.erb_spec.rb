require 'spec_helper'

describe "travels/edit" do
  before(:each) do
    @travel = assign(:travel, stub_model(Travel,
      :place => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit travel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", travel_path(@travel), "post" do
      assert_select "input#travel_place[name=?]", "travel[place]"
      assert_select "textarea#travel_body[name=?]", "travel[body]"
    end
  end
end

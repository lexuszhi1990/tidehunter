require 'spec_helper'

describe "articles/new" do
  before(:each) do
    assign(:article, stub_model(Article,
      :name => "MyString",
      :body => "MyText",
      :tag => "MyString"
    ).as_new_record)
  end

  it "renders new article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", articles_path, "post" do
      assert_select "input#article_name[name=?]", "article[name]"
      assert_select "textarea#article_body[name=?]", "article[body]"
      assert_select "input#article_tag[name=?]", "article[tag]"
    end
  end
end

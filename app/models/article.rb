class Article < ActiveRecord::Base
  attr_accessible :body, :name, :content_html
  before_save :fill_html_content

  private
  def fill_html_content
    self.content_html = Markdown.render(self.body)
  end
end

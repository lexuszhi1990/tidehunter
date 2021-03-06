class Article < ActiveRecord::Base
  before_save :fill_html_content

  # get the article's post time
  def posted_time(options = {})
    options.reverse_merge! format: '%A %b %-d, %Y %H:%M' # set the default time as "Thursday Sep 19, 2013 22:32"
    created_at.strftime(options[:format])
  end

  private
    def fill_html_content
      self.content_html = GitHub::Markdown.render_gfm(self.body)
    end
end

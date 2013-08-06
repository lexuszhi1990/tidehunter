class Markdown
  def self.render(text)
    return markdown_scope.render(text)
  end

  def self.markdown_scope(extensions={})
    options = {
      :autolink => true,
      :space_after_headers => true,
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :hard_wrap => true,
      :strikethrough =>true,
      :no_styles => true,
      :filter_html => true,
      :highlight => true
    }
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions.merge(options))
  end

end

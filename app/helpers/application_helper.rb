module ApplicationHelper
  def fix_url(url)
    return url if url.blank?

    if url.starts_with?("http://")
      return url
    else
      return "http://" + url
    end

  end


  def markdown(text, options = {})
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
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    sanitize markdown.render(text)
  end
end

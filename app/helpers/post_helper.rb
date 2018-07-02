module PostHelper
  def render_post_content(post)
    truncate(simple_format(post.content), length: 100, escape: false)
  end
end
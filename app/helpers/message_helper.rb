module MessageHelper
  def render_author_name(message)
    message.author ? message.author.name : "遊客"
  end
end
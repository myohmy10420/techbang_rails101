class MessagesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @message = @post.messages.new(messages_params)
    @message.author = current_user || nil
    @message.save
  end

  private

  def messages_params
    params.require(:message).permit(:content)
  end
end

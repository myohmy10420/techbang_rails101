class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :member_required, :only => [:new, :create]

  def new
    @post = @group.posts.build
  end

  def show
    @post = @group.posts.find(params[:id])
    @messages = @post.messages
    @new_message = Message.new
  end

  def create
    @post = @group.posts.new(posts_params)
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(posts_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to group_path(@group)
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end
  def posts_params
    params.require(:post).permit(:content)
  end

  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = " You are not member of this group!"
      redirect_to group_path(@group)
    end
  end
end

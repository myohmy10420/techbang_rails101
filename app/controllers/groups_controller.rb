class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :join, :quit]
  before_action :find_user_group, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @posts = @group.posts
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group.destroy

    redirect_to groups_path
  end

  def join
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
    else
      flash[:warning] = "You already joined this group."
    end

    redirect_to group_path(@group)
  end

  def quit
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
    else
      flash[:warning] = "you are not member of this group."
    end

    redirect_to group_path(@group)
  end

  private

  def find_group
    @group = Group.find(params[:id])
  end

  def find_user_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end
end

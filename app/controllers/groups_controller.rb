class GroupsController < ApplicationController
  before_action :logged_in_user , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group_and_check_permission, only:[:edit, :update, :destroy]

  def index
    @groups = Group.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render :eidt
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, alert: "Movie deleted"
  end

  private
    def find_group_and_check_permission
      @group = Group.find(params[:id])

      if current_user != @group.user
        redirect_to root_path, alert: "You have no permission."
      end
    end

    def group_params
      params.require(:group).permit(:title, :description)
    end
end

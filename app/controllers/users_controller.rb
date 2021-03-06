class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def edit
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Success"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Alpha-blog #{@user.username}"
      session[:user_id]=@user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username,:email,:password)
  end 

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if urrent_user != @user
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end 
end
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit show update destroy]
  before_action :require_same_user, only: %i[edit update]
  before_action :require_admin, only: %i[destroy]

  def index
    @users = User.all
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    flash[:danger] = "User #{@user.username} and all his/her articles have been deleted"
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    return if logged_in? && current_user.admin?
    return if current_user == @user

    flash[:danger] = 'You can only edit your own account'
    redirect_to users_path
  end

  def require_admin
    return if logged_in? && current_user.admin?

    flash[:danger] = 'Only admin users can perform that action'
    redirect_to users_path
  end
end

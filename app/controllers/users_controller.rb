class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :require_admin, only: [:destroy]
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Successfully Registered!"
      redirect_to root_url
    else
      render 'new'
    end
    #User.create(
    #  name: params[:user][:name],
    #  email: params[:user][:email]
    #)
    #redirect_to root_path
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Successfully edit!"
      redirect_to current_user
    else
        render "edit"
    end
  end

  def destroy
    user = User.find(params[:id]).destroy

    flash[:warning] = "Deleted user"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name,:email, :password, :password_confirmation)
    end

    def require_login
      unless logged_in?
        flash[:danger] = "Unauthorized Access! Please login..."
        redirect_to login_url
      end
    end

    def require_admin
      redirect_to root_url unless current_user.admin?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless @user == current_user
    end

end

class UsersController < ApplicationController
  before_filter :not_signed_in, :only => [:new, :create]
  before_filter :authenticate,  :except => [:show, :new, :create]
  before_filter :correct_user,  :only => [:edit, :update]
  before_filter :admin_user,    :only => :destroy

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = 'Sign up'
      @user.password.clear
      @user.password_confirmation.clear
      render 'new'
    end
  end

  def edit
    # @user fetched in correct_user filter
    @title = "Edit user"
  end

  def update
    # @user fetched in correct_user filter
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user == current_user
      flash[:notice] = "You can't destroy yourself."
    else
      user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def not_signed_in
      redirect_to(root_path) if signed_in?
    end

end

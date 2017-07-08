class UsersController < ApplicationController
  before_action :logged_in_user, except: [:index, :new, :create, :show,
    :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin!, only: :destroy
  before_action :load_user, except: [:index, :new, :create]

  def index
    @users = User.select(:id, :name, :email).order(name: :asc)
      .paginate page: params[:page], per_page: Settings.user.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t ".success"
      redirect_to root_url
    else
      flash[:danger] = t ".error"
      redirect_to request.referrer || root_url
    end
  end

  def show
    @posts = @user.posts
      .select(:id, :content, :picture, :title, :user_id, :created_at).post_sort
      .paginate page: params[:page], per_page: 20
  end

  def update
    super
  end

  def destroy
    if @user.destroy
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:danger] = t ".user_not_deleted"
      redirect_to users_url
    end
  end

  def following
    @title = t ".title"
    @users = @user.following.paginate page: params[:page],
      per_page: 20
    render :show_follow
  end

  def followers
    @title = t ".title"
    @users = @user.followers.paginate page: params[:page],
      per_page: 20
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    load_user
    redirect_to root_url unless @user.is_user? current_user
  end

  def verify_admin!
    redirect_to root_url unless current_user.is_admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    valid_info @user
  end
end

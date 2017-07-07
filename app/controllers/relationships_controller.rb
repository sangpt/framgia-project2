class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    render json: {
      html: render_to_string(partial: "users/unfollow", locals: {user: @user}, layout: false),
      followers: @user.followers.size
    }
  end

  def destroy
    @user = User.find_by id: params[:followed_id]
    current_user.unfollow @user
    render json: {
      html: render_to_string(partial: "users/follow", locals: {user: @user}, layout: false),
      followers: @user.followers.size
    }
  end
end

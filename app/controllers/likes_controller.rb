class LikesController < ApplicationController
  before_action :logged_in_user
  before_action :load_post, only: [:create, :destroy]

  def create
    current_user.likes.build(post_id: @post.id).save
    render json: {
      status: :success,
      like_number: @post.likes.size.to_s << " like".pluralize(@post.likes.size)
    }
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: @post.id).destroy
    render json: {
      status: :success,
      like_number: @post.likes.size.to_s << " like".pluralize(@post.likes.size)
    }
  end

  private

  def load_post
    @post = Post.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end

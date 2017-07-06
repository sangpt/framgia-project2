class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :load_post, only: [:edit, :update, :destroy]

  def create
    @post = current_user.posts.build post_params

    if @post.save
      render json: {status: :success, html: render_to_string(partial: "posts/post", locals: {post: @post}, layout: false)}
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def show
    @post = post.find_by id: params[:id]
  end

  def edit
    render json: {status: :success, html: render_to_string(partial: "posts/edit_form", locals: {post: @post}, layout: false)}
  end

  def update
    if @post.update_attributes post_params
      render json: {status: :success, html: render_to_string(partial: "posts/post", locals: {post: @post}, layout: false)}
    else

    end
  end

  def destroy
    if @post.destroy
      render json: {status: :success, message: "thanh cong"}
    else
      render json: {status: :error, message: "ko thanh cong"}
    end
  end

  private

  def post_params
    params.require(:post).permit :content, :picture, :title
  end

  def load_post
    @post = Post.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end

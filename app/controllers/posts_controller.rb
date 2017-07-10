class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :load_post, only: [:edit, :update, :destroy]
  before_action :verify_admin!, only: :destroy

  def create
    @post = current_user.posts.build post_params

    if @post.save
      tags = params[:tags]
      tags.split(",").each do |tag_name|
        tag = Tag.find_by(name: tag_name)

        if tag.nil?
          @post.tags.create name: tag_name
        else
          @post.post_tags.create tag_id: tag.id
        end
      end

      render json: {
        status: :success,
        html: render_to_string(partial: "posts/post", locals: {post: @post}, layout: false),
        placeholder: "Input tags here"
      }
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def show
    @post = Post.find_by id: params[:id]
  end

  def edit
    render json: {
      status: :success,
      html: render_to_string(partial: "posts/edit_form", locals: {post: @post}, layout: false)
    }
  end

  def update
    if @post.update_attributes post_params
      render json: {
        status: :success,
        html: render_to_string(partial: "posts/post", locals: {post: @post}, layout: false)
      }
    else
      render json: {
        status: :error
      }
    end
  end

  def destroy
    if @post.destroy
      render json: {status: :success}
    else
      render json: {status: :error}
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

  def verify_admin!
    redirect_to root_url unless current_user.is_admin?
  end
end

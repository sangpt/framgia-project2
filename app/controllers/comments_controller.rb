class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :load_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      render json: {
        status: :success,
        html: render_to_string(partial: "comments/comment", locals: {comment: @comment}, layout: false)
      }
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def show
    @comment = comment.find_by id: params[:id]
  end

  def edit
    render json: {
      status: :success,
      html: render_to_string(partial: "comments/edit_form", locals: {comment: @comment}, layout: false)
    }
  end

  def update
    if @comment.update_attributes comment_params
      render json: {
        status: :success,
        html: render_to_string(partial: "comments/comment", locals: {comment: @comment}, layout: false)
      }
    else
      render json: {
        status: :error,
        message: "ERROR"
      }
    end
  end

  def destroy
    if @comment.destroy
      render json: {status: :success}
    else
      render json: {status: :error}
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :post_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    redirect_to root_url if @comment.nil?
  end
end

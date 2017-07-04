class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :correct_comment, only: [:edit, :update, :destroy]

  private

  def correct_comment
    @comment = Comment.find_by id: params[:id]
    redirect_to root_url if @comment.nil?
  end
end

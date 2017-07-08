class TagsController < ApplicationController
  before_action :logged_in_user
  before_action :load_tag, only: :show

  def show
    @posts = @tag.posts.paginate page: params[:page], per_page: 10
  end

  private

  def load_tag
    @tag = Tag.find_by id: params[:id]
    redirect_to root_url if @tag.nil?
  end
end

class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed
        .select(:id, :content, :picture, :title, :user_id, :created_at).post_sort
        .paginate page: params[:page], per_page: 10
      @user = current_user
    end
  end

  def search
    q = params[:search]
    @users = User.where "name like '%#{q}%'"
    @posts = Post.where "content like '%#{q}%' or title like '%#{q}%'"
    @comments = Comment.where("content like '%#{q}%'")
    @tags = Tag.where "name like '%#{q}%'"
  end
end

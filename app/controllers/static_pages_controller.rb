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
    @comments = Comment.where "content like '%#{q}%'"
    @tags = Tag.where "name like '%#{q}%'"
  end

  def admin
    @count = {
      users: User.all.size,
      posts: Post.all.size,
      comments: Comment.all.size,
      likes: Like.all.size,
      tags: Tag.all.size
    }
  end

  def load_statistics
    choice = params[:choice]

    case choice
    when "today"
      time = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    when "this_week"
      time = Date.today.beginning_of_week..Date.today.end_of_week
    when "this_month"
      time = Date.today.beginning_of_month..Date.today.end_of_month
    when "this_year"
      time = Date.today.beginning_of_year..Date.today.end_of_year
    end

    @count = {
      users: User.where(created_at: time).size,
      posts: Post.where(created_at: time).size,
      comments: Comment.where(created_at: time).size,
      likes: Like.where(created_at: time).size,
      tags: Tag.where(created_at: time).size
    }
    admin if time == "all_the_time"
    render json: {
      count: @count
    }
  end
end

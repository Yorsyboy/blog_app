class UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @all_posts = @user.recent_posts
  end
end

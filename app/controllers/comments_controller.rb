class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: } }
    end
  end

  def create
    @user = current_user
    puts params
    @post = Post.find(params[:post_id])
    comment = Comment.new(comment_params)
    puts comment.user_id = @user.id
    puts comment.post_id = @post.id
    respond_to do |format|
      format.html do
        if comment.save
          flash[:success] = 'Comment created!'
          redirect_to user_post_path(@user, @post)
        else
          flash.now[:error] = 'Comment not created!'
          render :new, locals: { comment: }
        end
      end
    end
  end

  def destroy
    @comment = Comment.includes(:user, :post).find(params[:id])
    user = @comment.user
    post = @comment.post

    if @comment.destroy
      flash[:success] = 'Comment deleted!'
    else
      flash.now[:error] = 'Comment not deleted!'
    end
    redirect_to user_post_path(user, post)
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

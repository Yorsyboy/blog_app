class Api::CommentsController < ApplicationController
  before_action :authorize!, only: %i[index show], if: :user_signed_in?
  protect_from_forgery with: :null_session

  def index
    @comments = Comment.where(post_id: params[:post_id])

    if @comments.present?
      render json: @comments, status: :ok
    else
      render json: { errors: 'Comments not found' }, status: :not_found
    end
  end

  def create
    @comment = Comment.create(
      text: comment_params[:text],
      user: comment_params[:user],
      post: comment_params[:post]
    )

    json_response(@comment, :created)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

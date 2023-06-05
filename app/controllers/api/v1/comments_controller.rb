class Api::V1::CommentsController < ApplicationController
  before_action :fetch_comment, only: %i[show update destroy]
  before_action :fetch_article, only: %i[search create]

  def index
    @comments = Comment.all
    render json: @comments, status: 200
  end

  def show
    render json: @comment, status: 200
  end

  def create
    @comment = @article.comments.new(comment_params)

    if @comment.save
      render json: @comment, status: 200
    else
      render json: { error: 'Comment not created!' }
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: 200
    else
      render json: { error: 'Comment not updated!' }
    end
  end

  def destroy
    @comment.destroy
    render json: @comments, status: 200
  end

  def search
    @comments = @article.comments.all
    render json: @comments, status: 200
  end

  private

  def fetch_comment
    @comment = Article.find(params[:article_id]).comments.find_by(id: params[:id])
    render json: { error: 'Comment not found' }, status: 404 unless @comment
  end

  def fetch_article
    @article = Article.find_by(id: params[:article_id])
    render json: { error: 'Article not found' }, status: 404 unless @article
  end

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end

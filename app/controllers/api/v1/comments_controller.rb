class Api::V1::CommentsController < ApplicationController
  before_action :fetch_comment, only: %i[show update destroy]
  before_action :fetch_article, only: %i[search create]

  def index
    @comments = Comment.all
    render json: @comments, status: 200
  end

  def show
    if @comment
      render json: @comment, status: 200
    else
      render json: { error: 'Comment not found' }, status: 404
    end
  end

  def create
    @comment = @article.comments.new(comment: params[:comment])

    if @comment.save
      render json: @comment, status: 200
    else
      render json: { error: 'Comment not created!' }
    end
  end

  def update
    if @comment.update(comment: params[:comment])
      render json: @comment, status: 200
    else
      render json: { error: 'Comment not updated!' }
    end
  end

  def destroy
    if @comment
      @comment.destroy
      render json: @comments, status: 200
    else
      render json: { error: 'Comment not found' }, status: 404
    end
  end

  def search
    @comments = @article.comments.all
    render json: @comments, status: 200
  end

  private

  def fetch_comment
    @comment = Article.find(params[:article_id]).comments.find(params[:id])
  end

  def fetch_article
    @article = Article.find(params[:article_id])
  end
end

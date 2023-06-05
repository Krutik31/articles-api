class Api::V1::ArticlesController < ApplicationController
  before_action :fetch_article, only: %i[show update destroy]

  def index
    articles = Article.all.page params[:page]

    render json: articles, status: 200
  end

  def show
    if @article
      render json: @article, status: 200
    else
      render json: { error: 'Article not found' }, status: 404
    end
  end

  def create
    article = Article.new(article_params)

    if article.save
      render json: article, status: 200
    else
      render json: { error: 'Article not created!' }
    end
  end

  def update
    if @article.update(article_params)
      render json: @article, status: 200
    else
      render json: { error: 'Article not updated!' }
    end
  end

  def destroy
    if @article
      @article.destroy
      render json: @article, status: 200
    else
      render json: { error: 'Article not found' }, status: 404
    end
  end

  def search
    article = Article.find_by(title: params[:title])
    if article
      render json: article, status: 200
    else
      render json: { error: 'Article not found' }, status: 404
    end
  end

  private

  def fetch_article
    @article = Article.find_by(id: params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end

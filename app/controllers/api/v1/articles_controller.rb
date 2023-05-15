class Api::V1::ArticlesController < ApplicationController
  def index
    articles = if params.key?('page')
                 Article.all.limit(3).offset(3 * (params[:page].to_i - 1))
               else
                 Article.all
               end
    paginate articles, per_page: 3
    render json: articles, status: 200
  end

  def show
    article = Article.find(params[:id])
    if article
      render json: article, status: 200
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
    article = Article.find(params[:id])

    if article.update(article_params)
      render json: article, status: 200
    else
      render json: { error: 'Article not updated!' }
    end
  end

  def destroy
    article = Article.find(params[:id])
    if article
      article.destroy
      render json: article, status: 200
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

  def article_params
    params.require(:article).permit(:title, :body)
  end
end

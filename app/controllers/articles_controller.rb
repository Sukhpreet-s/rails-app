class ArticlesController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end

  def authorize_user
    article = Article.find(params[:id])
    unless article.user == current_user
      flash[:alert] = "You are not allowed make changes to other's articles"
      redirect_to article
    end
  end
end
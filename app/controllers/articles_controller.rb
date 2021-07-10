class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, except: %i[show index]
  before_action :require_same_user, only: %i[edit update destory]
  before_action :get_categories, only: %i[new create edit update]

  def show
    @categories = @article.categories
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(artcle_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article was saved successfully.'
      @categories.each do |category|
        category.article_count = category.articles.count
        category.save
      end
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(artcle_params)
      flash[:success] = 'Article was saved successfully.'
      @categories.each do |category|
        category.article_count = category.articles.count
        category.save
      end
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def artcle_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:warning] = 'You can only edit or delete your own article'
      redirect_to @article
    end
  end

  def get_categories
    @categories = Category.all
  end
end

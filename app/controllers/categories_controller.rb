class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[new index show]

  # caches_action :index

  def new
    @category = Category.new
    respond_to do |format|
      format.js { render layout: false }
      format.html do
        render 'new'
      end
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      @id = @category.id
      respond_to do |format|
        format.js { render layout: false }
        flash.now[:success] = 'Category was succeesfully created'
        format.html do
          flash[:success] = 'Category was succeesfully created'
          redirect_to @category
        end
      end
    else
      @id = params[:id]
      respond_to do |format|
        format.js { render layout: false }
        format.html do
          render 'new'
        end
      end
    end
  end

  def index
    @category = Category.find(params[:id]) if params[:id] && params[:id].to_i > 0
    @id = params[:id] if params[:id]
    @category ||= Category.new
    categories = Category.all
    @categories = categories.order('featured DESC').order('article_count DESC').order('name').paginate(page: params[:page],
                                                                                                       per_page: 12)

    respond_to do |format|
      format.js { render layout: false }
      format.html do
        render 'index'
      end
    end
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.js { render layout: false }
      format.html do
        render 'show'
      end
    end
  end

  def edit
    @category = Category.find(params[:id])
    if params[:togglefeatured] || params[:editcat]
      toggle_featured if params[:togglefeatured]
      if @category.featured?
        respond_to do |format|
          format.js { render layout: false }
          format.html do
            render 'edit'
          end
        end
      end
    end
  end

  def update
    @category = Category.find(params[:id])
    name = @category.name
    if @category.update(category_params)
      respond_to do |format|
        format.js { render layout: false }
        flash.now[:success] = 'Category was saved successfully.'
        format.html do
          flash[:success] = 'Category was saved successfully.'
          redirect_to categories_path
        end
      end
    else
      @category.name = name
      respond_to do |format|
        format.js { render layout: false }
        format.html do
          render 'edit'
        end
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      respond_to do |format|
        format.js { render layout: false }
        flash.now[:success] = 'Category was deleted successfully.'
        format.html do
          flash[:success] = 'Category was deleted successfully.'
          redirect_to request.referrer
        end
      end
    else
      respond_to do |format|
        format.js { render layout: false }
        format.html do
          redirect_to request.referrer
        end
      end
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :meta_description, :featured, :togglefeatured, :edit)
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:danger] = 'Only admins can perfome that action'
      redirect_to categories_path
    end
  end

  def toggle_featured
    @category.toggle!(:featured)
  end
end

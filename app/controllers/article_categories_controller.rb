class ArticleCategoriesController < ApplicationController
  before_action :set_article_category, only: %i[show desstroy]

  def show; end

  def destroy
    @article_category.destroy
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def set_article_category
    @article_category = article_category.find(params[:id])
  end
end

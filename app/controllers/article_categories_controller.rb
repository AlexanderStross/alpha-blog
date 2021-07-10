class ArticleCategoriesController < ApplicationController
  before_action :set_article_category, only: %i[show desstroy]

  def show; end

  def destroy
    @articleCategory.destroy
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def set_article_category
    @articleCategory = ArticleCategory.find(params[:id])
  end
end

class ArticleCategoryController < ApplicationController
  before_action :set_user, only: [:show]

  def destroy
    @articleCategory.destroy
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def set_user
    @articleCategory = ArticleCategory.find(params[:id])
  end
end

class PagesController < ApplicationController
  caches_action :home, :about, :contact

  def home; end

  def about; end

  def pricing; end

  def contact; end

  def admin; end
end

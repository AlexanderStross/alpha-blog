class AddArticleCountToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :article_count, :integer, default: 0
  end
end

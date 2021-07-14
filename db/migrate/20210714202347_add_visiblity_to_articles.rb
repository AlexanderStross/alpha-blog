class AddVisiblityToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :visiblity, :int
  end
end

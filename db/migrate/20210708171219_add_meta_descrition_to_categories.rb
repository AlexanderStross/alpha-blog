class AddMetaDescritionToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :meta_description, :string
  end
end

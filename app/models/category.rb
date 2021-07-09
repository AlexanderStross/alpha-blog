class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates_uniqueness_of :name
  validates :meta_description, length: { minium: 10, maximum: 155 }
  has_many :article_categories
  has_many :articles, through: :article_categories
end

class ArticleCategory < ApplicationRecord
  belongs_to :article, touch: true
  belongs_to :category, touch: true
end

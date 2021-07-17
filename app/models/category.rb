class Category < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: { case_sensive: false },
                   length: { minimum: 3, maximum: 30 }
  validates :meta_description, length: { minium: 10, maximum: 155 }
  has_many :article_categories, dependent: :destroy
  has_many :articles, through: :article_categories

  def create_slug
    name.downcase.gsub(' ', '-')
  end

  def update_slug
    update_attributes slug: assign_slug
  end

  def to_param
    # return the string of the slug stored in our database
    slug
  end

  private

  def assign_slug
    self.slug = create_slug
  end
end

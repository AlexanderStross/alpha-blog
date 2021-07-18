class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :user, touch: true
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  validates :title, presence: true,
                    uniqueness: { case_sensive: false },
                    length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 3000 }
  accepts_nested_attributes_for :categories
  validates :slug, uniqueness: { case_sensive: false }

  def create_slug
    title.downcase.gsub(' ', '-')
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

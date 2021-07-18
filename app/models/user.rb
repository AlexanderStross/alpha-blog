class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  validates :username, presence: true,
                       uniqueness: { case_sensive: false },
                       length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password

  def create_slug
    username.downcase.gsub(' ', '-')
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

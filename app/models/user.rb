class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :articles

  before_save { self.email = email.downcase }

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 6, maximum: 16 }

  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 }
end

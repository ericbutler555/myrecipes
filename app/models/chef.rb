class Chef < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  before_save { self.email = email.downcase }
  
  validates :chefname, presence: true,
                       length: { maximum: 30 }
  
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  has_many :recipes
  
  has_secure_password
  
  validates :password, presence: true,
                       length: { minimum: 5 },
                       allow_nil: true # won't allow null inputs on signup, but will allow in edit form, etc.
end

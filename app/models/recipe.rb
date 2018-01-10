class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true,
                          length: { minimum: 5, maximum: 500 }
  validates :chef_id, presence: true

  belongs_to :chef

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :comments, dependent: :destroy

  default_scope -> { order(updated_at: :desc) } # always make the most recent recipe the first listed (on top)
end

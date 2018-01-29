class Like < ApplicationRecord
  belongs_to :chef
  belongs_to :recipe

  validates_uniqueness_of :chef, scope: :recipe, message: "You have already liked this recipe"
end

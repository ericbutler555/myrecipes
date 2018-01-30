class Message < ApplicationRecord

  validates :content, presence: true

  validates :chef_id, presence: true

  belongs_to :chef

  def self.most_recent
    order(:created_at).last(20)
  end

end

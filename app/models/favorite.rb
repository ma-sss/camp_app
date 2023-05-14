class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :admin

  validates :admin_id, presence: true
  validates :user_id, presence: true
end

class Rating < ApplicationRecord
  validates :value, inclusion: { in: [-1, 1] }
  validates :user_id, uniqueness: {scope: :ad_id}
  belongs_to :user
  belongs_to :ad
end

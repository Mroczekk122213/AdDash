class User < ApplicationRecord
  validates :email, presence: true,
            format: { with: /\A([^@\s]+)@[a-z\d\-.]+\.[a-z]{2,}\z/i }
  validates :first_name, :last_name,
            presence: true,  length: {minimum: 2, maximum: 50}
end

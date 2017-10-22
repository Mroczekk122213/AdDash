class User < ApplicationRecord
  before_save :downcase_email
  validates :email, presence: true,
            format: { with: /\A([^@\s]+)@[a-z\d\-.]+\.[a-z]{2,}\z/i },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, :last_name, presence: true,
            length: {minimum: 2, maximum: 50}
has_secure_password
has_many :ads
has_many :ratings

def downcase_email
  email.downcase!
end

def full_name
  "#{first_name} #{last_name}"
end
end

class Ad < ApplicationRecord
validates :title, :description, presence: true
validates :image, presence: true unless Rails.env.test?
belongs_to :user
mount_uploader :image, ImageUploader
end

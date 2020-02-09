class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :image_url, allow_blank: true, format: { with: %r(\.(gif|jpg|pug)\Z)i, message: 'must be a url for GIF, JPG or png image.' }
end

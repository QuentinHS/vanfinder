class Listing < ApplicationRecord
  belongs_to :user

  has_one_attached :listing_image

  validates :price, presence: { message: "Please provide a price"}
  validates :description, presence: { message: "Please add a description"}
  validates :postcode, presence: { message: "Please give a postcode"}


end

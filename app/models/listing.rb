class Listing < ApplicationRecord
  resourcify
  belongs_to :user
  has_one :van, dependent: :destroy
  has_one_attached :listing_image, dependent: :purge_later
  accepts_nested_attributes_for :van, update_only: true
  
  validates :listing_image, presence: { message: "Please provide an image of your van"}
  validates :price, presence: { message: "Please provide a price for your van"}
  validates :description, presence: { message: "Please add a short description of your van"}
  validates :description, length: {minimum: 10, maximum: 500}
  validates :city, presence: { message: "Please provide the city or town for this listing"}
  validates :state, presence: { message: "Please provide the state for this listing"}
 

end

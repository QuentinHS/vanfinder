class Listing < ApplicationRecord
  resourcify
  belongs_to :user
  has_one :van, dependent: :destroy
  has_one_attached :listing_image, dependent: :purge
  accepts_nested_attributes_for :van, update_only: true
  
  validates :listing_image, presence: { message: "Please provide an image of your van"}
  validates :price, presence: { message: "Please provide a price"}
  validates :description, presence: { message: "Please add a description"}
  validates :description, length: {minimum:10, maximum:500}
  validates :city, presence: { message: "Please provide your city or town"}
  validates :state, presence: { message: "Please provide your state"}
 

end

class Listing < ApplicationRecord
  # Set rolify association with listings
  resourcify
  # Create listing relationship to user
  belongs_to :user
  # Create van relationship with user
  has_one :van, dependent: :destroy
  # Gives listing an uploaded image, ensure images are purged from cloud when listing is deleted
  has_one_attached :listing_image, dependent: :purge_later
  accepts_nested_attributes_for :van, update_only: true
  
  # Validations for listing attributes, ensuring essential attributes are provided, but allowing some to be optional. Essentially it requires enough information to ensure listings remain useful and consistent for all users. 
  validates :listing_image, presence: { message: "Please provide an image of your van"}
  validates :price, presence: { message: "Please provide a price for your van"}
  validates :description, presence: { message: "Please add a short description of your van"}
  # ensure description is not excessively long
  validates :description, length: {minimum: 10, maximum: 500}
  validates :city, presence: { message: "Please provide the city or town for this listing"}
  validates :state, presence: { message: "Please provide the state for this listing"}
 

end

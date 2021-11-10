class Listing < ApplicationRecord
  resourcify
  belongs_to :user
  has_one_attached :listing_image, dependent: :purge

  # validates :listing_image, attached: true, content_type: %i[png jpg jpeg]
  validates :price, presence: { message: "Please provide a price"}
  validates :description, presence: { message: "Please add a description"}
  validates :postcode, presence: { message: "Please give a postcode"}
  validates :description, length: {minimum:10, maximum:500}

end

class Van < ApplicationRecord
  belongs_to :listing
  has_many :amenity_vans, dependent: :destroy
  has_many :amenities, through: :amenity_vans

  accepts_nested_attributes_for :amenities, allow_destroy: true
  

end

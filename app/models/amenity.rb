class Amenity < ApplicationRecord
  # Relationships for amenity model
  has_many :amenity_vans, inverse_of: :van, dependent: :destroy
  has_many :vans, through: :amenity_vans


 
end

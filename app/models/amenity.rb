class Amenity < ApplicationRecord
    has_many :amenity_vans, dependent: :destroy
    has_many :vans, through: :amenity_vans
end

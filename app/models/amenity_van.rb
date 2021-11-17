class AmenityVan < ApplicationRecord
  belongs_to :van
  belongs_to :amenity

  accepts_nested_attributes_for :amenity
  
end

class AmenityVan < ApplicationRecord
  # Join table relationships
  belongs_to :van
  belongs_to :amenity
  # Nested form relationship
  accepts_nested_attributes_for :amenity
  
end

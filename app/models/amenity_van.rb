class AmenityVan < ApplicationRecord
  belongs_to :van
  belongs_to :amenity


  attr_accessor :enable
  
end

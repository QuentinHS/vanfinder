class Van < ApplicationRecord
  belongs_to :listing
  has_many :amenity_vans, dependent: :destroy
  has_many :amenities, through: :amenity_vans

  accepts_nested_attributes_for :amenities, allow_destroy: true



  # before_save :find_or_create_amenities

  # def find_or_create_amenities
  #   self.amenity_vans.each do |amenity_van|
  #     amenity_van.amenity = Amenity.find_or_create_by(name: amenity_van.amenity.name)
  #   end
  # end


end

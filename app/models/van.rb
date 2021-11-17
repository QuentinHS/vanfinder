class Van < ApplicationRecord
  belongs_to :listing
  has_many :amenity_vans, inverse_of: :van, dependent: :destroy
  has_many :amenities, through: :amenity_vans

  accepts_nested_attributes_for :amenity_vans





end

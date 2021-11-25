class Van < ApplicationRecord
  belongs_to :listing
  has_many :amenity_vans, inverse_of: :van, dependent: :destroy
  has_many :amenities, through: :amenity_vans

  accepts_nested_attributes_for :amenity_vans


  validates :make, presence: { message: "Please provide the make for this listing"}
  validates :model, presence: { message: "Please provide the model for this listing"}
  validates :year, presence: { message: "Please provide the year for this listing"}


end

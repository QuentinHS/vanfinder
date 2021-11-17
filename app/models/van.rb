class Van < ApplicationRecord
  belongs_to :listing
  has_many :amenity_vans, inverse_of: :van, dependent: :destroy
  has_many :amenities, through: :amenity_vans

  accepts_nested_attributes_for :amenity_vans

  def initialized_amenity_vans # this is the key method
    [].tap do |o|
      Amenity.all.each do |amenity|
        if c = amenity_vans.find { |c| c.amenity_id == amenity.id }
          o << c.tap { |c| c.enable ||= true }
        else
          o << AmenityVan.new(amenity: amenity)
        end
      end
    end
  end




end

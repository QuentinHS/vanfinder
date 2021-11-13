class Listing < ApplicationRecord
  resourcify
  belongs_to :user
  has_one_attached :listing_image, dependent: :purge
  # belongs_to :creator, -> { where(roles: {name: :creator}) }, through: :roles, class_name: 'User', source: :users

  # after_create :add_editor_role


  validates :listing_image, presence: { message: "Please provide an image of your van"}
  validates :price, presence: { message: "Please provide a price"}
  validates :description, presence: { message: "Please add a description"}
  validates :description, length: {minimum:10, maximum:500}
  validates :city, presence: { message: "Please provide your city or town"}
  validates :state, presence: { message: "Please provide your state"}
 

  private

  # def add_editor_role
  #   self.user.add_role :editor, @listing
  # end 

end

class Listing < ApplicationRecord
  resourcify
  belongs_to :user
  has_one_attached :listing_image, dependent: :purge
  # belongs_to :creator, -> { where(roles: {name: :creator}) }, through: :roles, class_name: 'User', source: :users

  # after_create :add_editor_role


  # validates :listing_image, attached: true, content_type: %i[png jpg jpeg]
  validates :price, presence: { message: "Please provide a price"}
  validates :description, presence: { message: "Please add a description"}
  validates :postcode, presence: { message: "Please give a postcode"}
  validates :description, length: {minimum:10, maximum:500}

  private

  # def add_editor_role
  #   self.user.add_role :editor, @listing
  # end 

end

class User < ApplicationRecord
  after_create :set_role, :add_editor

  rolify

  # Create new model called profile with one to one relationship to user, can put custom stuff in the profile without worrying about devise

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings, dependent: :destroy
  # has_many :creator_listings, -> { where(roles: {name: :creator}) }, through: :roles, source: :resource, source_type: :Listing

  validates_uniqueness_of :username
  validates_presence_of :username

  def set_role
    self.add_role :user if self.roles.blank?
  end

  def add_editor
    self.add_role :editor, Listing
  end




end

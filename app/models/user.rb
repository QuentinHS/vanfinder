class User < ApplicationRecord
  # Run set default role function
  after_create :set_role
  # Create relationships with messages
  has_many :messages, class_name: "Message", foreign_key: "recipient_id"
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  # Initiate rolify for user class
  rolify

  # Create new model called profile with one to one relationship to user, can put custom stuff in the profile without worrying about devise

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Gives a user a one-to-many relationship with listings
  has_many :listings, dependent: :destroy
  
  # Ensures users have a unique username
  validates_uniqueness_of :username
  validates_presence_of :username
  # Create default role for users
  def set_role
    self.add_role :user if self.roles.blank?
  end


end

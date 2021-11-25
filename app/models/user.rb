class User < ApplicationRecord
  after_create :set_role
  has_many :messages, class_name: "Message", foreign_key: "recipient_id"
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"

  extend FriendlyId
  friendly_id :username, use: :slugged

  rolify

  # Create new model called profile with one to one relationship to user, can put custom stuff in the profile without worrying about devise

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings, dependent: :destroy
  

  validates_uniqueness_of :username
  validates_presence_of :username

  def set_role
    self.add_role :user if self.roles.blank?
  end


end

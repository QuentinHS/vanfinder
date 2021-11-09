class User < ApplicationRecord

  # Create new model called profile with one to one relationship to user, can put custom stuff in the profile without worrying about devise


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings, dependent: :destroy

  validates_uniqueness_of :username
  validates_presence_of :username
end

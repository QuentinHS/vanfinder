class Message < ApplicationRecord
   belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
   belongs_to :sender, class_name: "User", foreign_key: "sender_id"
   scope :unread, -> { where read: false }

  validates :content, presence: true, length: { maximum: 500 }
  validates :sender_id, presence: true
  validates :recipient_id, presence: true

end

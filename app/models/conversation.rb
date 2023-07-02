class Conversation < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :recipient, class_name: 'User'
  
    has_many :messages, dependent: :destroy
    
    def opposed_user(user)
      user == sender ? recipient : sender
    end
  
    def self.between(sender, recipient)
      where(sender: sender, recipient: recipient).or(where(sender: recipient, recipient: sender))
    end
end

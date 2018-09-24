class Contact < ApplicationRecord
    belongs_to :company
    has_many :follows

    validates :email, presence: true
    validate :is_email?

    def is_email?
        if !email.include?('@')
            errors.add(:email, "Not a valid email")
        end
    end
end

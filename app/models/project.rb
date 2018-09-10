class Project < ApplicationRecord
    has_many :follows
    has_many :contacts, through: :follows
    belongs_to :company
    has_one_attached :drawing

    def serialize
        return {
            id:self.id,
            name: self.name,
            drawing_link: self.drawing_link,
            last_updated: self.updated_at,
            followers: self.follows.map{|follow| 
                {
                    id:follow.id,
                    up_to_date:follow.up_to_date,
                    email: follow.contact.email
                }
            }
        }
    end 

    def drawings_updated message
        puts 'send emails'
    end 
end

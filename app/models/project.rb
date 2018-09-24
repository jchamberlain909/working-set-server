class Project < ApplicationRecord
    has_many :follows
    has_many :contacts, through: :follows
    belongs_to :company
    has_one_attached :drawing

    validates :name, presence: true

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
        hashids = Hashids.new("this is my salt", 8)
        self.follows.each do |follow|
            follow.update(up_to_date: false)
            follower_url = "localhost:3000/download/#{hashids.encode(follow.id)}"
            ProjectMailer.with(
                follower_url: follower_url,
                 message: message, 
                 project_name: self.name,
                 email:follow.contact.email).drawing_update.deliver_later
        end 
    end 
end

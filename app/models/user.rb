class User < ApplicationRecord
    belongs_to :company, optional: true
    has_many :projects, through: :company

    has_secure_password
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true

    

end

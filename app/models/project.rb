class Project < ApplicationRecord
    has_many :follows
    has_many :contacts, through: :follows
    belongs_to :company
end

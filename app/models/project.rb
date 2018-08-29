class Project < ApplicationRecord
    has_many :drawings
    has_many :follows
    belongs_to :company
end

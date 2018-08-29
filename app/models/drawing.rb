class Drawing < ApplicationRecord
    belongs_to :project
    has_many :follows
    has_one_attached :drawing_file
end

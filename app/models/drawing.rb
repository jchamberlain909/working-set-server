class Drawing < ApplicationRecord
    belongs_to :project
    has_one_attached :drawing_file
end

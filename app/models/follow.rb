class Follow < ApplicationRecord
    belongs_to :contact
    belongs_to :project
end

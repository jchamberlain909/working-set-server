class User < ApplicationRecord
    belongs_to :company
    has_secure_password

    

end

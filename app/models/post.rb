class Post < ApplicationRecord
    
    validates :caption,  presence: true
       validates :cosmetic_id, presence: true
       validates :customer_id,  presence: true

end

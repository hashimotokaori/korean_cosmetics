class Post < ApplicationRecord
    
    belongs_to :customer
    has_many :post_comments, dependent: :destroy
    
       validates :caption,  presence: true
    
    def get_image(width, height)
    unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
    end   


end

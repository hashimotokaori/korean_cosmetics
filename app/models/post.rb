class Post < ApplicationRecord
    has_one_attached :image    
    belongs_to :customer
    belongs_to :cosmetic
    has_many :post_comments, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    
       validates :caption,  presence: true
    
    def get_image(width, height)
    unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
    end   


end

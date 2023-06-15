class AddReviewToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :review, :string
  end
end

class CreateCosmetics < ActiveRecord::Migration[6.1]
  def change
    create_table :cosmetics do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text:caption, null: false
      t.string :item_code, null: false, unique: true
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end

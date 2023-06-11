class CreateCosmetics < ActiveRecord::Migration[6.1]
  def change
    create_table :cosmetics do |t|
      t.string :name, null: false
      t.string :introduction, null: false
      t.integer :price, null: false
      t.string :image_id
      t.text:caption

      t.timestamps
    end
  end
end

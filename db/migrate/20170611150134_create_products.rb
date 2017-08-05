class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :/
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price, precision: 8, scale: 2local

      t.timestamps null: false
    end
  end
end

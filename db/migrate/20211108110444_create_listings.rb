class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.integer :postcode
      t.boolean :sold
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.decimal :price, precision: 9, scale: 2

      t.timestamps
    end
  end
end

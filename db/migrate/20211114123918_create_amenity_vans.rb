class CreateAmenityVans < ActiveRecord::Migration[6.1]
  def change
    create_table :amenity_vans do |t|
      t.references :van, null: false, foreign_key: true
      t.references :amenity, null: false, foreign_key: true

      t.timestamps
    end
  end
end

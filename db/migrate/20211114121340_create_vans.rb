class CreateVans < ActiveRecord::Migration[6.1]
  def change
    create_table :vans do |t|
      t.string :make
      t.string :model
      t.string :type
      t.string :roof_type
      t.integer :year
      t.integer :odometer
      t.integer :sleeps
      t.string :fuel_type
      t.integer :seats
      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end

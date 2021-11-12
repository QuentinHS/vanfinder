class AddCityToListings < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :city, :string
  end
end

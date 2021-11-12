class AddStateToListings < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :state, :string
  end
end

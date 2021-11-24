class AddVanTypeToVan < ActiveRecord::Migration[6.1]
  def change
    add_column :vans, :van_type, :string
  end
end

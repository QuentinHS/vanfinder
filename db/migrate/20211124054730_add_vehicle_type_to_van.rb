class AddVehicleTypeToVan < ActiveRecord::Migration[6.1]
  def change
    add_column :vans, :vehicle_type, :string
  end
end

class AddAccessCountToTenants < ActiveRecord::Migration[6.0]
  def change
    add_column :tenants, :access_count, :integer, default: 0
  end
end

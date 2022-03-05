class AddIndexToApiKeyTenants < ActiveRecord::Migration[6.0]
  def change
    add_index :tenants, :api_key, unique: true
  end
end

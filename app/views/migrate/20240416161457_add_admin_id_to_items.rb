class AddAdminIdToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :admin_id, :integer
  end
end

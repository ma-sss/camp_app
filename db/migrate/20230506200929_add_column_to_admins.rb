class AddColumnToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :name, :string
    add_column :admins, :address, :string
    add_column :admins, :telephone_number, :string
  end
end

class AddAccountsInfo < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :username, :string, null: false, default: ''
    add_column :accounts, :name, :string, default: ''
    add_column :accounts, :role, :integer, null: false, default: 0
  end
end

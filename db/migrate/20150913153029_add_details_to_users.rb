class AddDetailsToUsers < ActiveRecord::Migration
  def change

  add_column :users, :first_name, :string
  add_column :users, :last_name, :string
  add_column :users, :company, :string
  add_column :users, :position, :string
  add_column :users, :intro, :text
  add_column :users, :country_code, :string
  add_column :users, :screen_name, :string
  add_column :users, :skill, :text, array: true, default: []
  add_column :users, :need, :text, array: true, default: []
  end
end

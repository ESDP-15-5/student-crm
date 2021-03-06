class AddAdditionColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :middlename, :string
    add_column :users, :gender, :string
    add_column :users, :birthdate, :date
    add_column :users, :passportdetails, :string
  end
end

class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :user, index: true, unique: true, foreign_key: true
      t.string :phone
      t.string :additional_phone
      t.string :skype

      t.timestamps null: false
    end
  end
end

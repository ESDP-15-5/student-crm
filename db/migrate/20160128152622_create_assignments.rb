class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :period, index:true, foreign_key: true
      t.integer :file_version
      t.integer :grade
      t.text :review

      t.timestamps null: false
    end
  end
end

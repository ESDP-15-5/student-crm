class AddDeletedAtToCourseElementFile < ActiveRecord::Migration
  def change
    add_column :course_element_files, :deleted_at, :datetime
    add_index :course_element_files, :deleted_at
  end
end

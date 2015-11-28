class AddDeletedAtToCourseElements < ActiveRecord::Migration
  def change
    add_column :course_elements, :deleted_at, :datetime
    add_index :course_elements, :deleted_at
  end
end

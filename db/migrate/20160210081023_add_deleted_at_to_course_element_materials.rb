class AddDeletedAtToCourseElementMaterials < ActiveRecord::Migration
  def change
    add_column :course_element_materials, :deleted_at, :datetime
    add_index :course_element_materials, :deleted_at
  end
end

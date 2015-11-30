class CreateCourseElementMaterials < ActiveRecord::Migration
  def change
    create_table :course_element_materials do |t|
      t.string :title
      t.text :content
      t.references :course_element_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

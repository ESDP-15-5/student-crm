class AddRowOrderToCourseElements < ActiveRecord::Migration
  def change
    add_column :course_elements, :row_order, :integer
  end
end

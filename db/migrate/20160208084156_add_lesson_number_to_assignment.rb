class AddLessonNumberToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :lesson_id, :integer
  end
end

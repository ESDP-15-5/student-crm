class AddCourseIdToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :course_id, :integer
  end
end

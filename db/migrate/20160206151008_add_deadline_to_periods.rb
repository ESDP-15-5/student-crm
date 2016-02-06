class AddDeadlineToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :deadline, :boolean
    add_column :periods, :deadline_time, :datetime
  end
end

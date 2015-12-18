class AddGroupIdToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :group_id, :integer
  end
end

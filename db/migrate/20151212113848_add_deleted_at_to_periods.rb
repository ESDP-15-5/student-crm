class AddDeletedAtToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :deleted_at, :datetime
    add_index :periods, :deleted_at
  end
end

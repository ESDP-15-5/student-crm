class AddAttachmentHomeworkToAssignments < ActiveRecord::Migration
  def self.up
    change_table :assignments do |t|
      t.attachment :homework
    end
  end

  def self.down
    remove_attachment :assignments, :homework
  end
end

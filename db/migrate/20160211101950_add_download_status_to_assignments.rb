class AddDownloadStatusToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :DownloadStatus, :boolean
  end
end

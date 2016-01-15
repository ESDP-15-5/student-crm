class AddAdditionColumnsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :theoretical_time, :integer
    add_column :courses, :practical_time, :integer
    add_column :courses, :educational_cost, :integer
  end
end

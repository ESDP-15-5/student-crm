class Course < ActiveRecord::Base
  audited
  has_many :groups
  has_many :course_elements
end

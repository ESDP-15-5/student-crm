class CourseElementMaterial < ActiveRecord::Base

  belongs_to :course_element

  validates :title, presence: true

end

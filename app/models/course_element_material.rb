class CourseElementMaterial < ActiveRecord::Base
  acts_as_paranoid
  audited

  belongs_to :course_element

  validates :title, presence: true

end

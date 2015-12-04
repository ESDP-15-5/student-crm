class Course < ActiveRecord::Base
  acts_as_paranoid

  audited
  has_many :groups
  has_many :course_elements

  validates :name, presence:  true


end

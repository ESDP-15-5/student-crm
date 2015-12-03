class CourseElement < ActiveRecord::Base
  acts_as_paranoid

  audited
  belongs_to :course

  has_many :course_element_files
  has_many :course_element_materials
  has_many :periods

  ELEMENT_TYPES = ['Лекция','Вебинар','Лабораторная','Контрольная']

  include RankedModel
  ranks :row_order, :with_same => :course_id

end

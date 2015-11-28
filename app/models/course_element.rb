class CourseElement < ActiveRecord::Base
  audited
  belongs_to :course
  has_many :periods

  ELEMENT_TYPES = ['Лекция','Вебинар','Лабораторная','Контрольная']
end

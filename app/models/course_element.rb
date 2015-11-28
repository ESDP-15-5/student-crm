class CourseElement < ActiveRecord::Base
  acts_as_paranoid

  audited
  belongs_to :course
  has_many :periods

  ELEMENT_TYPES = ['Лекция','Вебинар','Лабораторная','Контрольная']
end

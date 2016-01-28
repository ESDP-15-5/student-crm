class CourseElement < ActiveRecord::Base
  ELEMENT_TYPES = ['Лекция','Вебинар','Лабораторная','Контрольная']

  acts_as_paranoid
  audited

  belongs_to :course

  has_many :course_element_files
  has_many :course_element_materials
  has_many :periods

  validates :course_id, presence: true
  validates :theme, presence: true
  validates :element_type, presence: true,  inclusion: {in: ELEMENT_TYPES}


  include RankedModel
  ranks :row_order, :with_same => :course_id

  def name_with_type
    "#{theme} ( #{element_type} )"
  end

end

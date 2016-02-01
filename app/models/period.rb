class Period < ActiveRecord::Base
  acts_as_paranoid

  audited

  belongs_to :course

  belongs_to :group

  belongs_to :course_element
  has_many :attendances
  has_many :students, through: :attendances
  has_many :assignments

  validates :title, presence:  true
  validates :commence_datetime, presence:  true
end

class Group < ActiveRecord::Base
  acts_as_paranoid

  audited

  belongs_to :course
  has_many :periods
  has_many :group_memberships
  has_many :students, through: :group_memberships, source: :user

  validates :name, presence:  true, length: { minimum: 2}, uniqueness: true
  validates_format_of :name, :with => /\A[A-Za-zА-Яа-я]+[1-6]{1}\z/, message: "Допустимо только Название Группы и цифра например (HTML1), цифра от 1 до 6"
end

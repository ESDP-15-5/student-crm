class Group < ActiveRecord::Base
  acts_as_paranoid

  audited

  belongs_to :course
  has_many :periods
  has_many :group_memberships
  has_many :students, through: :group_memberships

  validates :name, presence:  true
end

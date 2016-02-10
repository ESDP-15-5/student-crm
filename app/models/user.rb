class User < ActiveRecord::Base

  rolify

  audited
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         # :recoverable,
         :rememberable, :trackable, :validatable

  def password_required?
    new_record? ? false : super
  end


  has_many :group_memberships
  has_many :groups, through: :group_memberships

  has_many :attendances
  has_many :periods, through: :attendances
  has_and_belongs_to_many :roles, join_table: :users_roles

  has_many :recipient_depositories
  has_many :contact_lists, through: :recipient_depositories

  has_one :contact, dependent: :destroy
  accepts_nested_attributes_for :contact

  has_many :assignments

  has_attached_file :image,
                    styles: {medium: '300x300>', thumb: '100x100>'},
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image,
                                    content_type: ['image/jpeg', 'image/gif', 'image/png']

  validates :name, presence: true, length: {maximum: 250}
  validates :surname, presence: true, length: {maximum: 250}
  validates :gender, presence: true
  validates :email, presence: true
  validates :passportdetails, presence: true

  # validates :phone1, presence: true
  # my_regex = /\A(\+996)([0-9]{9})\z/
  # validates_format_of :phone1,
  #                     :with => my_regex,
  #                     message: "Phone must be like +996xxxYYYYYY, where xxx - your operator's code and YYYYYY - your phone number"
  #
  # validates_format_of :phone2,
  #                     :with => my_regex,
  #                     :allow_blank => true,
  #                     message: "Phone must be like +996xxxYYYYYY, where xxx - your operator's code and YYYYYY - your phone number"

  after_initialize do
    self.contact ||= self.build_contact()
  end

  def full_name
    "#{surname} #{name} #{middlename}"
  end

  def self.all_students_except(student_ids)
    student_role = Role.find_by(name: :student)
    students = student_role.users
    students.where.not(id: student_ids).order(created_at: :desc)
  end

  def self.search(search, scoped_users)
    if search
      where('users.name || users.surname || users.middlename LIKE ?', "%#{search}%")
    else
      scoped_users
    end
  end

end

class Assignment < ActiveRecord::Base
  before_save :set_file_name

  audited

  belongs_to :user
  belongs_to :period

  acts_as_paranoid

  has_attached_file :homework

  validates :grade, allow_nil: true, numericality: {greater_than_or_equal_to: 0,less_than_or_equal_to: 100, }

  validates :homework, presence: true
  validates_attachment_content_type :homework,
                                    content_type: ['application/x-compressed', 'application/x-zip-compressed.zip', 'application/zip', 'multipart/x-zip', 'application/msword', 'text/plain']


  def normalized_file_name
    if $file
      extension = File.extname($file.original_filename)
      student = User.find(self.user_id)
      period = Period.find(self.period_id)
      lesson = $lesson_id
      group = Group.find(period.group_id)
      version = self.name
      "#{group.name}-#{student.name}-#{student.surname}-hw-#{lesson}-v#{version}#{extension}"
    end
  end

  def give_name_of_new_version(user_id, period_id)
    number = Assignment.where(period_id: period_id, user_id: user_id).order(name: :desc).first.name.to_i + 1
  end

  private

  def set_file_name
    self.homework_file_name = normalized_file_name
  end


end

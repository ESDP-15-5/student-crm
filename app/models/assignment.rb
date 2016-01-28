class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :period

  has_attached_file :homework

  validates :homework, presence: true
  validates_attachment_content_type :homework,
                                    content_type: ['application/x-compressed', 'application/x-zip-compressed.zip', 'application/zip', 'multipart/x-zip', 'application/msword', 'text/plain']
end

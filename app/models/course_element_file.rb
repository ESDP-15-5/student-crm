class CourseElementFile < ActiveRecord::Base
  acts_as_paranoid

  include Paperclip::Glue

  belongs_to :course_element

  has_attached_file :file,
                    styles: { medium: '300x300>', thumb: '100x100>'},
                    default_url: '/images/:style/missing.png'

  do_not_validate_attachment_file_type :file


end

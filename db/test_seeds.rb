# ActiveRecord::Migration.drop_table(:users)
# ActiveRecord::Migration.drop_table(:courses)
element_type = CourseElement::ELEMENT_TYPES

admin = User.create!(name: 'Farid',
                     surname: 'Babazov',
                     gender: 'Мужчина',
                     birthdate: '06.11.1992',
                     contact_attributes: {
                         phone:'996772183644',
                         additional_phone:'',
                         skype:'skype.admin'},
                     passportdetails:'MVD 50-01',
                     email: 'a@a.a', password: '12345678', password_confirmation: '12345678')

admin.add_role 'admin'

courses=[]
courses.push Course.create(name: "CourseForDelete", starts_at: nil, ends_at: nil)
courses.push Course.create(name: "CourseForEdit", starts_at: nil, ends_at: nil)
courses.push Course.create(name: "HTML", starts_at: nil, ends_at: nil)

CourseElement.create(course: courses[2],
                     theme: "Введение",
                     element_type: element_type.sample)
CourseElement.create(course: courses[2],
                     theme: "Начало работы",
                     element_type: element_type.sample)

CourseElementFile.create(course_element_id: 1,
                         file_file_name: 'test_file.jpg',
                         file_content_type:'image/jpeg'
)

CourseElementMaterial.create(course_element_id: 1,
                             title: 'Раздатка-1',
                             content:'Содержимое раздатки 1'
)
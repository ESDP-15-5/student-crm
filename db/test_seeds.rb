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

groups = []
groups.push Group.create(name: 'Html1', course: courses[2])
groups.push Group.create(name: 'Html2', course: courses[2])


list = ContactList.create!(title: 'Лист получателей')


Role.create!(name: 'student')


5.times do
  student = User.create!(
      name: Faker::Name.first_name,
      surname: Faker::Name.last_name,
      middlename: Faker::Name.first_name,
      gender: ['Мужчина', 'Женщина'].sample,
      birthdate: Faker::Date.backward,
      contact_attributes: {
          phone:('996550123456'),
          additional_phone:('996550123456'),
          skype:((Faker::Name.name.downcase!).split(' ')).join('_')
      },
      passportdetails: Faker::Lorem.word,
      email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com",
      password: 'password',
      password_confirmation: 'password',
      roles:[Role.find_by(name:'student')]
  )
  GroupMembership.create!(group: groups[0], user_id: student.id);
end
student1 = User.create!(
    name: 'Иван',
    surname: 'Иванов',
    middlename: 'Иваныч',
    gender: 'Мужчина',
    birthdate: '06.11.1992',
    contact_attributes: {
        phone:('996772183644'),
        additional_phone:(''),
        skype: 'ivan'
    },
    passportdetails: 'Mvd 50-05',
    email: 'ivan@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    roles:[Role.find_by(name:'student')]
)
GroupMembership.create!(group: groups[0], user_id: student1.id);
RecipientDepository.create!(user_id: student1.id, contact_list_id: list.id)

student2 = User.create!(
    name: 'Вася',
    surname: 'Пупкин',
    middlename: '',
    gender: 'Мужчина',
    birthdate: '06.11.1992',
    contact_attributes: {
        phone:('996550362180'),
        additional_phone:(''),
        skype: 'vasya'
    },
    passportdetails: 'Mvd 50-05',
    email: 'vasya@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    roles:[Role.find_by(name:'student')]
)
GroupMembership.create!(group: groups[0], user_id: student2.id);

# Sms Service Accounts
login_nikita = SmsServiceAccount.create!(login: 'faridbabazov', password: 'eAswyztN')



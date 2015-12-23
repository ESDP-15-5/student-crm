# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create!(id: 1, name: 'student')
Role.create!(id: 2, name: 'manager')
Role.create!(id: 3, name: 'tutor')
Role.create!(id: 4, name: 'techsuport')
Role.create!(id: 5, name: 'admin')

phonecodes = (550..559).to_a
phonecodes.push (700..709).to_a
phonecodes.push (770..779).to_a
# phonecodes.push [543, 545] #I don't know if anyone is still using fonex
phonecodes.flatten!

password = 'password'

#creating students
50.times do
  User.create!(
      name: Faker::Name.first_name,
      surname: Faker::Name.last_name,
      middlename: Faker::Name.first_name,
      gender: ['Мужчина', 'Женщина'].sample,
      birthdate: Faker::Date.backward,
      phone1: ('+996' + phonecodes.sample.to_s + rand(100000..999999).to_s),
      phone2: ('+996' + phonecodes.sample.to_s + rand(100000..999999).to_s),
      skype: ((Faker::Name.name.downcase!).split(' ')).join('_'),
      passportdetails: Faker::Lorem.word,
      email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com",
      password: password,
      password_confirmation: password,
      roles:[Role.find_by(name:'student')]
  )
end

manager = User.create!(name: 'manager',
                       surname: 'manager',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       phone1: '+996772180825',
                       phone2: '+996772180825',
                       skype: 'skype.daniyar',
                       passportdetails:'abijjljlk',
                       email: 'manager@gmail.com', password: password, password_confirmation: password)

manager.add_role 'manager'

student = User.create!(name: 'Student',
                       surname: 'Lastname',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       phone1: '+996772180825',
                       phone2: '+996772180825',
                       skype: 'skype.daniyar',
                       passportdetails:'abijjljlk',
                       email: 'student@gmail.com', password: password, password_confirmation: password)

student.add_role 'student'

admin = User.create!(name: 'Admin',
                     surname: 'Lastname',
                     gender: 'Мужчина',
                     birthdate: '02.09.1992',
                     phone1: '+996772180825',
                     phone2: '+996772180825',
                     skype: 'skype.admin',
                     passportdetails:'MVD 50-01',
                     email: 'admin@gmail.com', password: password, password_confirmation: password)

admin.add_role 'admin'

tutor = User.create!(name: 'Tutor',
                     surname: 'Lastname',
                     gender: 'Мужчина',
                     birthdate: '02.09.1992',
                     phone1: '+996772180825',
                     phone2: '+996772180825',
                     skype: 'skype.tutor',
                     passportdetails:'MVD 50-01',
                     email: 'tutor@gmail.com', password: password, password_confirmation: password)

tutor.add_role 'tutor'


courses = []

courses.push Course.create(name: "HTML", starts_at: nil, ends_at: nil)
courses.push Course.create(name: "Ruby on Rails", starts_at: nil, ends_at: nil)

element_type = CourseElement::ELEMENT_TYPES

course_elements = []

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Введение",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Начало работы",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Введение в синтаксис",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Развертка приложения",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Основы баз данных",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Глубокий анализ данных",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Если ничего не пошло",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Многопоточное программирование",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Клиент Серверные решения",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Основные тэги HTML5",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Логические операторы",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Фрэймворки",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Работа над ошибками",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Командная работа",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Системный анализ данных",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Примеры из практики",
                                          element_type: element_type.sample)

course_elements.push CourseElement.create(course: courses.sample,
                                          theme: "Система заголовков",
                                          element_type: element_type.sample)

groups = []
groups.push Group.create(name: 'Группа13', course: courses.sample)


periods = []
periods.push Period.create(title: "Занятие 13",
                           commence_datetime: 1450375200000,
                           course_element_id: course_elements.sample,
                           group_id: groups.sample)
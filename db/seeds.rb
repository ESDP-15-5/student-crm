element_type = CourseElement::ELEMENT_TYPES

array_dates = [
    "01/Feb/2016 18:00:30 +0600",
    "03/Feb/2016 18:00:30 +0600",
    "05/Feb/2016 18:00:30 +0600",
    "08/Feb/2016 18:00:30 +0600",
    "10/Feb/2016 18:00:30 +0600",
    "12/Feb/2016 18:00:30 +0600",
    "15/Feb/2016 18:00:30 +0600",
    "17/Feb/2016 18:00:30 +0600",
    "19/Feb/2016 18:00:30 +0600",
    "22/Feb/2016 18:00:30 +0600"
]
array_themes = [
    "Введение",
    "Начало работы",
    "Введение в синтаксис",
    "Развертка приложения",
    "Основы баз данных",
    "Глубокий анализ данных",
    "Если ничего не пошло",
    "Многопоточное программирование",
    "Клиент Серверные решения",
    "Основные тэги HTML5",
    "Логические операторы",
    "Фрэймворки",
    "Работа над ошибками",
    "Командная работа",
    "Системный анализ данных",
    "Примеры из практики",
    "Система заголовков"
]

def create_course_element(course, theme, element_type)
  CourseElement.create(course: course,
                        theme: theme,
                        element_type: element_type)
end

def create_period(title, dates, course_elements_html, group,  course, deadline)
  deadline_time = deadline ? dates.to_datetime + 3: nil
  Period.create(title: title,
              commence_datetime:dates.to_datetime,
              course_element: course_elements_html,
              group: group,
              course: course,
              deadline: deadline,
              deadline_time: deadline_time
  )
end

Role.create!(id: 1, name: 'student')
Role.create!(id: 2, name: 'manager')
Role.create!(id: 3, name: 'teacher')
Role.create!(id: 4, name: 'assistent')
Role.create!(id: 5, name: 'admin')

phonecodes = (550..559).to_a
phonecodes.push (700..709).to_a
phonecodes.push (770..779).to_a
# phonecodes.push [543, 545] #I don't know if anyone is still using fonex
phonecodes.flatten!

password = 'password'

courses = []

courses.push Course.create(name: "Ruby on Rails",
                           starts_at: '2015-04-23',
                           ends_at: '2016-02-20',
                           practical_time: 140,
                           theoretical_time: 75,
                           educational_cost: 72000)
courses.push Course.create(name: "HTML",
                           starts_at: '2015-04-23',
                           ends_at: '2016-02-20',
                           practical_time: 200,
                           theoretical_time: 100,
                           educational_cost: 135000)

course_elements_html = []
course_elements_ruby = []

array_themes.each do |theme|
  course_elements_ruby.push create_course_element(courses[0],theme,element_type.sample)
  course_elements_html.push create_course_element(courses[1],theme,element_type.sample)
end

groups = []
groups.push Group.create(name: 'RoR1', course: courses[0])
groups.push Group.create(name: 'RoR2', course: courses[0])
groups.push Group.create(name: 'HTML1', course: courses[1])
groups.push Group.create(name: 'HTML2', course: courses[1])


Period.create(title: "1# Вводное",
                           commence_datetime: "10/Feb/2016 16:29:30 +0100".to_datetime,
                           course_element: course_elements_ruby.sample,
                           group: groups[0],
                           course: courses[0])
Period.create(title: "2# Основы",
                           commence_datetime: "13/Feb/2016 16:30:30 +0100".to_datetime,
                           course_element: course_elements_ruby.sample,
                           group: groups[0],
                           course: courses[0])

############# Занятия HTML для группы HTML1 и HTML2
array_dates.each_with_index do |date,i|
  deadline = [TRUE, FALSE, TRUE]
  create_period(array_themes[i],date,course_elements_html[i],groups[2], courses[1], deadline.sample)
  create_period(array_themes[i],date,course_elements_html[i],groups[3], courses[1], deadline.sample)
end

#creating students
20.times do
  student = User.create!(
      name: Faker::Name.first_name,
      surname: Faker::Name.last_name,
      middlename: Faker::Name.first_name,
      gender: ['Мужчина', 'Женщина'].sample,
      birthdate: Faker::Date.backward,
      contact_attributes: {
          phone:('996' + phonecodes.sample.to_s + rand(100000..999999).to_s),
          additional_phone:('996' + phonecodes.sample.to_s + rand(100000..999999).to_s),
          skype:((Faker::Name.name.downcase!).split(' ')).join('_')
      },
      passportdetails: Faker::Lorem.word,
      email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com",
      password: password,
      password_confirmation: password,
      roles:[Role.find_by(name:'student')]
  )
  GroupMembership.create!(group: groups.sample, user_id: student.id)
end

manager = User.create!(name: 'manager',
                       surname: 'manager',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       contact_attributes: {
                           phone:'996559250209',
                           additional_phone:'',
                           skype:'skype.daniyar'},
                       passportdetails:'abijjljlk',
                       email: 'manager@gmail.com',
                       password: password,
                       password_confirmation: password,
                       roles:[Role.find_by(name:'manager')])
GroupMembership.create!(group: groups[0], user_id: manager.id)
GroupMembership.create!(group: groups[1], user_id: manager.id)

student = User.create!(name: 'Student',
                       surname: 'Lastname',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       contact_attributes: {
                           phone:'996559250209',
                           additional_phone:'',
                           skype:'skype.daniyar'},
                       passportdetails:'abijjljlk',
                       email: 'student@gmail.com',
                       password: password,
                       password_confirmation: password,
                       roles:[Role.find_by(name:'student')])
GroupMembership.create!(group: groups[2], user_id: student.id)

admin = User.create!(name: 'Farid',
                     surname: 'Babazov',
                     gender: 'Мужчина',
                     birthdate: '06.11.1992',
                     contact_attributes: {
                         phone:'996772183644',
                         additional_phone:'',
                         skype:'skype.admin'},
                     passportdetails:'MVD 50-01',
                     email: 'admin@gmail.com',
                     password: password,
                     password_confirmation: password,
                     roles:[Role.find_by(name:'admin')])

teacher = User.create!(name: 'Teacher',
                     surname: 'Lastname',
                     gender: 'Мужчина',
                     birthdate: '02.09.1992',
                     contact_attributes: {
                         phone:'996772183644',
                         additional_phone:'',
                         skype:'skype.teacher'},
                     passportdetails:'MVD 50-01',
                     email: 'teacher@gmail.com',
                     password: password,
                     password_confirmation: password,
                     roles:[Role.find_by(name:'teacher')])
GroupMembership.create!(group: groups[0], user_id: teacher.id)
GroupMembership.create!(group: groups[1], user_id: teacher.id)


# Sms Service Accounts
login_nikita = SmsServiceAccount.create!(login: 'faridbabazov', password: 'eAswyztN')


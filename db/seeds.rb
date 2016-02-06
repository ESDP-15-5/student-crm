# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_course_element(course, element_type)
  course_elements = []
  course_elements.push CourseElement.create(course: course,
                                            theme: "Введение",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Начало работы",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Введение в синтаксис",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Развертка приложения",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Основы баз данных",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Глубокий анализ данных",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Если ничего не пошло",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Многопоточное программирование",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Клиент Серверные решения",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Основные тэги HTML5",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Логические операторы",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Фрэймворки",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Работа над ошибками",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Командная работа",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Системный анализ данных",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Примеры из практики",
                                            element_type: element_type.sample)

  course_elements.push CourseElement.create(course: course,
                                            theme: "Система заголовков",
                                            element_type: element_type.sample)
end

def create_period(group, course_elements_html, course)
  periods = []
  periods.push Period.create(title: "Введение в HTML",
                             commence_datetime: "24/Dec/2015 18:00:30 +0600".to_datetime,
                             course_element: course_elements_html.sample,
                             group: group,
                             course: course)
  periods.push Period.create(title: "Обычный текст или абзац",
                             commence_datetime: "28/Dec/2015 18:00:30 +0600".to_datetime,
                             course_element: course_elements_html.sample,
                             group: group,
                             course: course)
  periods.push Period.create(title: "Ссылки",
                             commence_datetime: "31/Dec/2015 18:00:30 +0600".to_datetime,
                             course_element: course_elements_html.sample,
                             group: group,
                             course: course)
  periods.push Period.create(title: "Списки",
                             commence_datetime: "04/Jan/2015 18:00:30 +0600".to_datetime,
                             course_element: course_elements_html.sample,
                             group: group,
                             course: course)
  periods.push Period.create(title: "Адpеса",
                             commence_datetime: "07/Jan/2015 18:00:30 +0600".to_datetime,
                             course_element: course_elements_html.sample,
                             group: group,
                             course: course)
  periods.push Period.create(title: "Логические стили",
                             commence_datetime: "11/Jan/2015 18:00:30 +0600".to_datetime,
                             course_element: course_elements_html.sample,
                             group: group,
                             course: course)
  periods.push Period.create(title: "Физические стили",
                             commence_datetime: "14/Jan/2015 18:00:30 +0600".to_datetime,
                             course_element: course_elements_html.sample,
                             group: group,
                             course: course)
  periods.push Period.create(title: "Специальные символы",
                             commence_datetime: "18/Jan/2015 18:00:30 +0600".to_datetime,
                             course_element: course_elements_html.sample,
                             group: group,
                             course: course)
  periods.push Period.create(title: "Рисунки",
                             commence_datetime: "21/Jan/2015 18:00:30 +0600".to_datetime,
                             course_element: course_elements_html.sample,
                             group: group,
                             course: course)
end

Role.create!(id: 1, name: 'student')
Role.create!(id: 2, name: 'manager')
Role.create!(id: 3, name: 'teacher')
Role.create!(id: 4, name: 'techsuport')
Role.create!(id: 5, name: 'admin')

phonecodes = (550..559).to_a
phonecodes.push (700..709).to_a
phonecodes.push (770..779).to_a
# phonecodes.push [543, 545] #I don't know if anyone is still using fonex
phonecodes.flatten!

password = 'password'

courses = []

courses.push Course.create(name: "HTML",starts_at: '2015-04-23', ends_at: '2016-02-20', practical_time: 200, theoretical_time: 100, educational_cost: 135000)
courses.push Course.create(name: "Ruby on Rails",starts_at: '2015-04-23', ends_at: '2016-02-20',practical_time: 140, theoretical_time: 75, educational_cost: 72000)

element_type = CourseElement::ELEMENT_TYPES

course_elements_html = create_course_element(courses[0], element_type)
course_elements_ruby = create_course_element(courses[1], element_type)

groups = []
groups.push Group.create(name: 'RoR1', course: courses[1])
groups.push Group.create(name: 'RoR2', course: courses[1])
groups.push Group.create(name: 'HTML1', course: courses[0])
groups.push Group.create(name: 'HTML2', course: courses[0])


Period.create(title: "1# Вводное",
                           commence_datetime: "19/Dec/2015 16:29:30 +0100".to_datetime,
                           course_element: course_elements_ruby.sample,
                           group: groups[1],
                           course: courses[1])
Period.create(title: "2# Основы",
                           commence_datetime: "20/Dec/2015 16:30:30 +0100".to_datetime,
                           course_element: course_elements_ruby.sample,
                           group: groups[1],
                           course: courses[1])

############# Занятия HTML для группы HTML1
create_period(groups[2], course_elements_html, courses[0])


############# Занятия HTML для группы HTML2
create_period(groups[3], course_elements_html, courses[0])

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
                       email: 'manager@gmail.com', password: password, password_confirmation: password)

manager.add_role 'manager'

student = User.create!(name: 'Student',
                       surname: 'Lastname',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       contact_attributes: {
                           phone:'996559250209',
                           additional_phone:'',
                           skype:'skype.daniyar'},
                       passportdetails:'abijjljlk',
                       email: 'student@gmail.com', password: password, password_confirmation: password)

student.add_role 'student'
admin = User.create!(name: 'Farid',
                     surname: 'Babazov',
                     gender: 'Мужчина',
                     birthdate: '06.11.1992',
                     contact_attributes: {
                         phone:'996772183644',
                         additional_phone:'',
                         skype:'skype.admin'},
                     passportdetails:'MVD 50-01',
                     email: 'admin@gmail.com', password: password, password_confirmation: password)

admin.add_role 'admin'

teacher = User.create!(name: 'Teacher',
                     surname: 'Lastname',
                     gender: 'Мужчина',
                     birthdate: '02.09.1992',
                     contact_attributes: {
                         phone:'996772183644',
                         additional_phone:'',
                         skype:'skype.teacher'},
                     passportdetails:'MVD 50-01',
                     email: 'teacher@gmail.com', password: password, password_confirmation: password)

teacher.add_role 'teacher'




# Sms Service Accounts
login_nikita = SmsServiceAccount.create!(login: 'faridbabazov', password: 'eAswyztN')


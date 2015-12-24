# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



users = User.create!([{email: 'test@mail.ru', password: '12345678'},{email: 'a@a.a', password: '12345678'}])

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
groups.push Group.create(name: 'RoR1', course: courses[1])
groups.push Group.create(name: 'RoR2', course: courses[1])
groups.push Group.create(name: 'HTML1', course: courses[0])
groups.push Group.create(name: 'HTML2', course: courses[0])

periods = []
periods.push Period.create(title: "1# Вводное",
                           commence_datetime: "19/Dec/2015 16:29:30 +0100".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[1])
periods.push Period.create(title: "2# Основы",
                           commence_datetime: "20/Dec/2015 16:30:30 +0100".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[1])


############# Занятия HTML для группы HTML1
periods.push Period.create(title: "Введение в HTML",
                           commence_datetime: "24/Dec/2015 18:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[0])
periods.push Period.create(title: "Обычный текст или абзац",
                           commence_datetime: "28/Dec/2015 18:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[0])
periods.push Period.create(title: "Ссылки",
                           commence_datetime: "31/Dec/2015 18:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[0])
periods.push Period.create(title: "Списки",
                           commence_datetime: "04/Jan/2015 18:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[0])
periods.push Period.create(title: "Адpеса",
                           commence_datetime: "07/Jan/2015 18:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[0])
periods.push Period.create(title: "Логические стили",
                           commence_datetime: "11/Jan/2015 18:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[0])
periods.push Period.create(title: "Физические стили",
                           commence_datetime: "14/Jan/2015 18:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[0])
periods.push Period.create(title: "Специальные символы",
                           commence_datetime: "18/Jan/2015 18:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[0])
periods.push Period.create(title: "Рисунки",
                           commence_datetime: "21/Jan/2015 18:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[2],
                           course: courses[0])


############# Занятия HTML для группы HTML2
periods.push Period.create(title: "Введение в HTML",
                           commence_datetime: "24/Dec/2015 20:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[3],
                           course: courses[0])
periods.push Period.create(title: "Обычный текст или абзац",
                           commence_datetime: "28/Dec/2015 20:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[3],
                           course: courses[0])
periods.push Period.create(title: "Ссылки",
                           commence_datetime: "31/Dec/2015 20:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[3],
                           course: courses[0])
periods.push Period.create(title: "Списки",
                           commence_datetime: "04/Jan/2016 20:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[3],
                           course: courses[0])
periods.push Period.create(title: "Адpеса",
                           commence_datetime: "07/Jan/2016 20:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[3],
                           course: courses[0])
periods.push Period.create(title: "Логические стили",
                           commence_datetime: "11/Jan/2016 20:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[3],
                           course: courses[0])
periods.push Period.create(title: "Физические стили",
                           commence_datetime: "14/Jan/2016 20:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[3],
                           course: courses[0])
periods.push Period.create(title: "Специальные символы",
                           commence_datetime: "18/Jan/2016 20:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[3],
                           course: courses[0])
periods.push Period.create(title: "Рисунки",
                           commence_datetime: "21/Jan/2016 20:00:30 +0600".to_datetime,
                           course_element: course_elements.sample,
                           group: groups[3],
                           course: courses[0])






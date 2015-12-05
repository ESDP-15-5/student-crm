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
# ActiveRecord::Migration.drop_table(:users)
# ActiveRecord::Migration.drop_table(:courses)
element_type = CourseElement::ELEMENT_TYPES

users = User.create!([{email: 'test@mail.ru', password: '12345678'},{email: 'a@a.a', password: '12345678'}])
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
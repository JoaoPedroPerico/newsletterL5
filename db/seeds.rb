5.times.each do |n|
  Email.create(subject: Faker::Educator.course_name, body: Faker::Lorem.paragraph(sentence_count: 30))
end

Subscriber.create(email: "jdoe@email.com")

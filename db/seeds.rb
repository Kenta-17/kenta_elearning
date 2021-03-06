# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(
  name: "Admin User", 
  email: "admin@gmail.com", 
  password: "password",
  admin: true
)

50.times do |n|
  User.create(
      name: Faker::Games::Pokemon.name, 
      email: "user#{n+1}@email.com", 
      password: "password"
)
end

20.times do |n|
  title = Faker::Name.unique.name
  description =  "Lorem Epsum"
  Category.create!(title: title,description: description)

  10.times do
    content = Faker::Lorem.word
    word = Category.all.sample.words.build content: content
    word.choices = [
      Choice.new(content: content, correct: true),
      Choice.new(content: Faker::Music.instrument, correct: false),
      Choice.new(content: Faker::Music.chord, correct: false)
    ].shuffle
    word.save(validate: false)
  end
end
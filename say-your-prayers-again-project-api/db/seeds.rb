# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
dave = User.create(username: 'Dave', password: 'password')
mary = User.create(username: 'Mary', password: 'password')
omar = User.create(username: 'Omar', password: 'password')

Prayer.create(title: 'My mom has cancer', body: 'Lord, please heal her.', user: omar)
Prayer.create(title: "I am going to propose to my gf.", body: 'God, please make her my wife.', user: omar)
Prayer.create(title: 'Election 2020', body: 'I sure would appreciate a shake-up of some sort.', user: mary)
Prayer.create(title: 'Graduation', body: 'Father God, please help me to achieve it.', user: dave)

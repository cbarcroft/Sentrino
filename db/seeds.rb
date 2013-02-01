# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  :email => 'chrisabarcroft@gmail.com',
  :password => 'testpass',
  :password_confirmation => 'testpass')

User.create(
  :email => 'christopher.d.ferris@gmail.com',
  :password => 'password',
  :password_confirmation => 'password')


# Action Types
actiontypes = ActionType.create([
		{:name => "Ping", :route => "ping"},
		{:name => "Temperature", :route => "temp"},
		{:name => "Humidity", :route => "humidity"}
	])
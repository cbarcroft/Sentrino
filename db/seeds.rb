# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@ChrisB = User.create(
  :email => 'chrisabarcroft@gmail.com',
  :password => 'testpass',
  :password_confirmation => 'testpass')

@ChrisDevice = @ChrisB.devices.build(
	:nickname => 'Home',
	:model => 'Uno',
	:ip => '76.28.236.232')
@ChrisDevice.save

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

#Associate Action Types to Devices
@ChrisDevice.actions.build(:action_type_id => ActionType.where("name = 'Ping'").first.id).save
@ChrisDevice.actions.build(:action_type_id => ActionType.where("name = 'Temperature'").first.id).save
@ChrisDevice.actions.build(:action_type_id => ActionType.where("name = 'Humidity'").first.id).save



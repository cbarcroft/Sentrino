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

@ChrisF = User.create(
  :email => 'christopher.d.ferris@gmail.com',
  :password => 'password',
  :password_confirmation => 'password')

@HomeDevice = @ChrisF.devices.build(
	:nickname => 'Home',
	:model => 'Uno',
	:ip => '192.94.9.46')
@HomeDevice.save


# Action Types
SensorType.create(:name => "Status", :method => "status") unless SensorType.where('name = ?', ["Status"]).first
SensorType.create(:name => "Temperature", :method => "temp") unless SensorType.where('name = ?', ["Temperature"]).first
SensorType.create(:name => "Humidity", :method => "humidity") unless SensorType.where('name = ?', ["Humidity"]).first

#Associate Action Types to Devices
@ChrisDevice.actions.build(:action_type_id => SensorType.where("name = 'Status'").first.id).save
@ChrisDevice.actions.build(:action_type_id => SensorType.where("name = 'Temperature'").first.id).save
@ChrisDevice.actions.build(:action_type_id => SensorType.where("name = 'Humidity'").first.id).save



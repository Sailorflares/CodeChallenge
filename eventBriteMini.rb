class Event
	attr_reader :name
	attr_reader :date
	attr_reader :invites
	
	def initialize(name, date)
		@name = name
		@date = date
		@invites = Hash.new()
	end	

	def addInvite(invite) 
		unless (self.invites[invite.person])
			self.invites[invite.person] = invite
		end
	end

	def getInvite(person)
		return self.invites[person]
	end

	def attendees
		self.invites.keys
	end

end

class Person
	attr_reader :firstName
	attr_reader :lastName
	attr_reader :invites

	def initialize(firstName, lastName)
		@firstName = firstName
		@lastName = lastName
		@invites = Hash.new()
	end

	def addInvite(invite)
		unless (self.invites[invite.event])
			self.invites[invite.event] = invite
		end
	end

	def events
		self.invites.keys
	end

end

class Invite
	attr_reader :event
	attr_reader :person

	def initialize(person, event)
		@person = person
		@event = event		
	end
end

class EventbriteService
	attr_reader :events
	attr_reader :people

	def initialize
		@events = []
		@people = []
	end

	def createInvite(person, event)

		invite = event.getInvite(person)
	
		return invite if invite
		
		invite = Invite.new(person, event)
		event.addInvite(invite)
		person.addInvite(invite)
		
		invite
	end

	def createPerson(firstName, lastName)
		binding.pry
		person = Person.new(firstName, lastName)
		self.people << person

		person
	end

	def createEvent(name, date)
		event = Event.new(name, date)
		self.events << event

		event
	end		
end

/
service = EventbriteService.new

people = [
	{ :firstName => "Sam", :lastName => "Winchester" },
	{ :firstName => "Dean", :lastName => "Winchester" },
	{ :firstName => "Castiel", :lastName => "Angel" }
]

events = [
	{ :name => "Supernatural Convention", :date => "December 2016"},
	{ :name => "It's Supernatural: The Musical", :date => "August 2016"}
]

people.each do |person|
	service.createPerson(person[:firstName], person[:lastName])
end

events.each do |event|
	service.createEvent(event[:name], event[:date])
end

service.createInvite(service.people[0], service.events[0])
/

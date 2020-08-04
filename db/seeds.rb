# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'database_cleaner'
DatabaseCleaner.clean_with(:truncation)

INSTRUMENTS = ["violin", "viola", "cello", "string bass", "clarinet", "flute", "saxophone", "bassoon", "oboe", "trumpet", "trombone", "horn", "tuba", "percussion", "drum set", "guitar", "electric bass", "vocals", "soprano", "mezzo-soprano", "alto", "tenor", "baritone", "bass"]
SECONDARY = ["none", "none", "none", "none", "none", "none", "none", "none", "violin", "viola", "cello", "string bass", "clarinet", "flute", "saxophone", "bassoon", "drum set", "guitar", "electric bass"]

200.times do 
    instrument_one = ""
    instrument_two = ""
    while instrument_one == instrument_two do
        instrument_one = INSTRUMENTS.sample
        instrument_two = SECONDARY.sample
    end 
    name = Faker::Name.name
    email = name.downcase.split.join("_") + "@example.com"
    User.create(name: name,
    password: "pa$sw0rd",
    email: email,
    phone_number: Faker::PhoneNumber.phone_number,
    primary_instrument_or_voice_part: instrument_one,
    secondary_instrument: instrument_two,
    image_url: Faker::Avatar.image)
end

ENSEMBLES = ["Community Orchestra", "Community Band", "Big Band O' Fun", "Chamber Choir", "Community Singers", "Symphony Orchestra", "Marching Band", "The Lock, Stock, and Barrels", "Grayson's Wanna-B's", "Pops Ensemble"]

ENSEMBLES.each do |ensemble|
    website = "http://" + ensemble.downcase.split.join("_") + ".com"
    ensemble = Ensemble.create(name: ensemble,
    website: website,
    phone_number: Faker::PhoneNumber.phone_number,
    email_contact: ensemble.downcase.split.join("_") + "@example.com",
    description: "A really fun ensemble!",
    image_url: Faker::Avatar.image)
    Membership.create(user_id: User.all.sample.id,
    ensemble_id: ensemble.id,
    admin: true,
    performing_roles: "none",
    administrative_roles: "Personnel Manager")
end

PROLES = ["none", "an awesome musician", "First Chair", "Second Chair", "Third Chair", "conductor"]
AROLES = ["none", "none", "none", "President", "Vice-President", "Secretary", "Treasurer", "none", "none", "none", "none", "none", "none", "none"]

500.times do 
    Membership.create(user_id: User.all.sample.id,
    ensemble_id: Ensemble.all.sample.id,
    admin: false,
    performing_roles: PROLES.sample,
    administrative_roles: AROLES.sample)
end

EVENT = ["Rehearsal", "Rehearsal", "Rehearsal", "Rehearsal", "Performance"]
STARTDATES = ["Tuesday, September 1 at 7:00 PM", "Wednesday, September 2 at 7:00 PM", "Thursday, September 3 at 7:00 PM", "Friday, September 4 at 7:00 PM", "Saturday, September 5 at 7:00 PM"]
ENDDATES = ["Tuesday, September 1 at 9:00 PM", "Wednesday, September 2 at 9:00 PM", "Thursday, September 3 at 9:00 PM", "Friday, September 4 at 9:00 PM", "Saturday, September 5 at 9:00 PM"]
BOOLEANSAMPLE = [true, false]

Ensemble.all.each do |ensemble|
    event_counter = 0 
    while event_counter < EVENT.length do 
        event = Event.create(ensemble_id: ensemble.id,
        start_time: STARTDATES[event_counter],
        end_time: ENDDATES[event_counter],
        place: "Shell Auditorium",
        description: "You better be here!",
        mandatory: BOOLEANSAMPLE.sample)
        ensemble.users.each do |user|
            UserEvent.create(user_id: user.id,
            event_id: event.id,
            attending: "undeclared",
            attended: false)
        end
        event_counter += 1 
    end 
end  



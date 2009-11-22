namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    # [Mentor, Instrument, Location].each(&:delete_all)
    
    Instrument.populate 8 do |instrument|
      instrument.title = Populator.words(1..2).titleize
    end
        # 
        # Mentor.populate 12 do |mentor|
        #   mentor.name = Faker::Name.first_name
        #   mentor.surname = Faker::Name.last_name
        #   mentor.email   = Faker::Internet.email
        #   mentor.phone   = Faker::PhoneNumber.phone_number
        #   mentor.address = Faker::Address.street_address + " " + Faker::Address.city
        # end
        # 
        # Location.populate 16 do |location|
        #   location.title    = Populator.words(1..2).titleize
        #   location.address  = Faker::Address.street_address
        #   location.city     = Faker::Address.city
        #   location.zip      = Faker::Address.uk_postcode
        # end
  end
end
require "rest-client"
require "json"
require "geocoder"

require_relative "lib/garages"
require_relative "lib/destinations"


def create_destination
  puts"What is the next destination you need to find parking near?  You can enter a zip code, building name, or address."
  input = Geocoder.search(gets.strip).first.coordinates

  Destination.new(input)
end


def create_garage
  destination = create_destination
  input = destination.input

  url = 'https://data.cityofnewyork.us/api/views/xbtj-c7ca/rows.json'
  response = RestClient.get(url)
  parsed_response = JSON.parse(response)
  

  parking_garages = parsed_response['data'].map do |garage|
    {
      name: garage[10],
      coordinates: [garage[12][1].to_f, garage[12][2].to_f],
      zip: garage[13],
      size: garage[15],
      phone: garage[14],
      address: garage[12][0]
    }
  end 

  distances = parking_garages.map do |garage|
    garage.merge({distance_between: Geocoder::Calculations.distance_between(input, garage[:coordinates])
    })
  end

  closest = distances.sort_by { |garage| garage[:distance_between] }.first
  
  garage_zip = closest[:zip]
  garage_address = closest[:address].delete('{' '}').gsub!('"', ' ').gsub(/\w+/, &:capitalize).gsub(' : ', ': ').gsub(' , ', ', ').gsub("State: Ny", "State: NY")
  garage_phone = closest[:phone]
  garage_size = closest[:size]
  garage_name = closest[:name]


  Garage.new(garage_zip, garage_address, garage_phone, garage_size, garage_name)
end



#Run the program
puts "Welcome to the NYC Parking Lot Locator."
garage = create_garage

puts "The closest garage to your destination is:"
puts "---------------------------------------------"
puts "#{garage.garage_name}"
puts "#{garage.garage_address}"
puts "---------------------------------------------"
puts
puts "Enter 'Phone' for contact information, 'Size' for the garage size, or 'All' for all garage information.  Enter 'Quit' to quit the program."

user_response = gets.strip.downcase

until user_response == "quit"
  if user_response == "phone"
    puts
    puts "---------------------------------------------"
    puts "Phone Number: #{garage.garage_phone}"
    puts "---------------------------------------------"
    puts
    puts "Enter 'Phone' for contact information, 'Size' for the garage size, or 'All' for all garage information.  Enter 'Quit' to quit the program."
    user_response = gets.strip.downcase
  
  elsif user_response == "size"
    puts
    puts "---------------------------------------------"
    puts "Garage Size: #{garage.garage_size} spaces"
    puts "---------------------------------------------"
    puts
    puts "Enter 'Phone' for contact information, 'Size' for the garage size, or 'All' for all garage information.  Enter 'Quit' to quit the program."
    user_response = gets.strip.downcase
  
  elsif user_response == "all"
    puts
    puts "---------------------------------------------"
    puts "#{garage.garage_name}"
    puts "#{garage.garage_address}"
    puts " Phone Number: #{garage.garage_phone}"
    puts " Garage Size: #{garage.garage_size} spaces"
    puts "---------------------------------------------"
    puts
    puts "Enter 'Phone' for contact information, 'Size' for the garage size, or 'All' for all garage information.  Enter 'Quit' to quit the program."
    user_response = gets.strip.downcase
  else 
    puts
    puts "---------------------------------------------"
    puts "Sorry, I didn't recognize that command."
    puts "---------------------------------------------"
    puts
    puts "Enter 'Phone' for contact information, 'Size' for the garage size, or 'All' for all garage information.  Enter 'Quit' to quit the program."
    user_response = gets.strip.downcase
  end
end
puts
puts "Thank you for using the NYC Parking Lot Locator."
require "rest-client"
require "json"
require "geocoder"

require_relative "lib/garages"
require_relative "lib/destinations"

def create_destination
  puts "What is the next destination you need to find parking near?  You can enter a zip code, building name, or address."
  input = gets.strip.to_s
  input_coordinates = Geocoder.search(input).first.coordinates
  Destination.new(input_coordinates)
end


def create_garage
  destination = create_destination
  input = destination.input

  json_file = File.read('merged_coordinates_dataset.json')
  coordinates_file = JSON.parse(json_file)

  parking_garages = coordinates_file["data"].map do |garage|
    {
      name: garage[9],
      coordinates: [garage[24][0].to_f, garage[24][1].to_f],
      zip: garage[18],
      size: garage[22],
      phone: garage[21],
      address: garage[13]
    }
  end

  distances = parking_garages.map do |garage|
    Geocoder.configure(:timeout => 15)
    garage.merge({distance_between: Geocoder::Calculations.distance_between(input, garage[:coordinates])})   
  end

  closest = distances.sort_by { |garage| garage[:distance_between] }.first

  garage_zip = closest[:zip]
  garage_address = closest[:address]
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


#url = 'https://data.cityofnewyork.us/api/views/r4rz-9ajc/rows.json'

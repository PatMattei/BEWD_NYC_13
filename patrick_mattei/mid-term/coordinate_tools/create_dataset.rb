require "json"
require "geocoder"

json_file = File.read("garage_dataset.json")
parsed_file = JSON.parse(json_file)

coordinates_array = []

parsed_file["data"].each do |garage|
  Geocoder::Configuration.timeout = 10
  coordinates = Geocoder.search(garage[13]).first.coordinates
  puts "#{coordinates}"
  coordinates_array << coordinates
  sleep(2)
end

File.open("garage_coordinates.json", "w") { |file|  file.write  ("#{coordinates_array}")}
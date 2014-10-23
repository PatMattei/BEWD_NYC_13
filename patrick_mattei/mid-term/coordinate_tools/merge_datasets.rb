require "json"

coordiantes_json_file = File.read('garage_coordinates.json')
coordinates_file = JSON.parse(coordiantes_json_file)

dataset_json_file = File.read('garage_dataset.json')
datasets_file = JSON.parse(dataset_json_file)


merged_files = []
counter = 0

datasets_file["data"].map do |garage|
  garage << coordinates_file[counter]
  counter += 1
  merged_files << garage
end

File.open("../merged_coordinates_dataset.json", "w") { |file|  file.write  ("#{merged_files}")}
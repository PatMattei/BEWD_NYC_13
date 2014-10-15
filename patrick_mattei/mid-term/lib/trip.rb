class Trip
  attr_accessor :trip_zips

  def initialize(number_of_stops, trip_zips)
    @number_of_stops = number_of_stops
    @trip_zips = trip_zips
  end

end

class Apartment
  attr_reader :number
  attr_accessor :renter, :rent

  def initialize(number, square_feet, bedroom, bathroom) 
    @number = number 
    @square_feet = square_feet 
    @bedroom = bedroom 
    @bathroom = bathroom
  end

end

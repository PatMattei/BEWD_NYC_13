class Building
  attr_accessor :apartments

  def initialize(name, address)
    @name = name
    @address = address
    @apartments = []
  end

  def view_apartments
    apartments.each do |apartment|
      puts "Number: #{apartment.number}"
    end
  end
end

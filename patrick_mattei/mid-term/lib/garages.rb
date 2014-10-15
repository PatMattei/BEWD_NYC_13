class Garage
  attr_accessor :garage_name, :garage_zip, :garage_address, :garage_phone, :garage_size,:garage_number

  def initialize(garage_zip, garage_address, garage_phone, garage_size, garage_name)
    @garage_zip = garage_zip
  	@garage_address = garage_address
  	@garage_phone = garage_phone
  	@garage_size = garage_size
  	@garage_name = garage_name
  end
end
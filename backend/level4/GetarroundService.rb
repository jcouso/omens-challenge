require "json"
require_relative("./Rental")

class GetArroundService
  def initialize
    file = File.open("./data/input.json").read
    data = JSON.parse(file)
    @cars = data["cars"]
    @rentals = data["rentals"]
  end

  def run
  end

  def get_car(car_id)
    @cars.select { |car| car["id"] == car_id }.first
  end

  def run
    result = @rentals.map do |rental_data|
      car = get_car(rental_data["car_id"])
      actions = Rental.new(car: car,
                           start_date: rental_data["start_date"],
                           end_date: rental_data["end_date"],
                           distance: rental_data["distance"]).run
      { id: rental_data["id"], actions: actions }
    end

    File.open("./data/output.json", "w") { |f| f.write(result.to_json) }
  end
end

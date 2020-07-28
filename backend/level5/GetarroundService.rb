require "json"
require_relative("./Rental")

class GetArroundService
  def initialize
    file = File.open("./data/input.json").read
    data = JSON.parse(file)
    @cars = data["cars"]
    @rentals = data["rentals"]
    @options = data["options"]
  end

  def get_car(car_id)
    @cars.select { |car| car["id"] == car_id }.first
  end

  def get_options(rental_id)
    @options.select { |option| option["rental_id"] == rental_id }
  end

  def run
    result = @rentals.map do |rental_data|
      car = get_car(rental_data["car_id"])
      options = get_options(rental_data["id"])

      rental = Rental.new(car: car,
                          options: options,
                          start_date: rental_data["start_date"],
                          end_date: rental_data["end_date"],
                          distance: rental_data["distance"])

      rental.run

      { id: rental_data["id"], options: rental.mapped_options, actions: rental.get_actions }
    end

    File.open("./data/output.json", "w") { |f| f.write(JSON.pretty_generate(result)) }
  end
end

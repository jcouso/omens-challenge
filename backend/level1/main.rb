require "json"
require "date"

class GetArroundService
  def initialize
    file = File.open("./data/input.json").read
    data = JSON.parse(file)
    @cars = data["cars"]
    @rentals = data["rentals"]
    @result = calculate_rental_prices
    File.open("./data/output.json", "w") { |f| f.write(@result.to_json) }
  end

  def time_price(car, start_date, end_date)
    ((Date.parse(end_date).mjd - Date.parse(start_date).mjd) + 1) * car["price_per_day"]
  end

  def distance_price(car, distance)
    car["price_per_km"] * distance
  end

  def total_price(car:, start_date:, end_date:, distance:)
    time_price(car, start_date, end_date) + distance_price(car, distance)
  end

  def get_car(car_id)
    @cars.select { |car| car["id"] == car_id }.first
  end

  def calculate_rental_prices
    @result = @rentals.map do |rental|
      car = get_car(rental["car_id"])

      price = total_price(car: car,
                          start_date: rental["start_date"],
                          end_date: rental["end_date"],
                          distance: rental["distance"])

      { id: rental["id"], price: price }
    end
  end
end

GetArroundService.new

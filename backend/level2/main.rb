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
    rental_days = total_rental_days(start_date, end_date)
    (1..rental_days).map do |day|
      discount = if day > 1 && day <= 4
          0.90
        elsif day > 4 && day <= 10
          0.70
        elsif day > 10
          0.50
        else
          1
        end
      discount * car["price_per_day"]
    end.reduce(:+)
  end

  def distance_price(car, distance)
    car["price_per_km"] * distance
  end

  def total_price(car:, start_date:, end_date:, distance:)
    time_price(car, start_date, end_date).to_i + distance_price(car, distance)
  end

  def total_rental_days(start_date, end_date)
    (Date.parse(end_date).mjd - Date.parse(start_date).mjd) + 1
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
                          distance: rental["distance"]).to_i

      { id: rental["id"], price: price }
    end
  end
end

GetArroundService.new

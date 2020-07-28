require "json"
require "date"

class GetArroundService
  def initialize
    file = File.open("./data/input.json").read
    data = JSON.parse(file)
    @cars = data["cars"]
    @rentals = data["rentals"]
    @daily_inssurance = 100
    @result = calculate_rental_prices
    File.open("./data/output.json", "w") { |f| f.write(@result.to_json) }
  end

  def time_price(car, rental_days)
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

  def total_price(car:, rental_days:, distance:)
    time_price(car, rental_days).to_i + distance_price(car, distance)
  end

  def total_rental_days(start_date, end_date)
    (Date.parse(end_date).mjd - Date.parse(start_date).mjd) + 1
  end

  def get_car(car_id)
    @cars.select { |car| car["id"] == car_id }.first
  end

  def calculate_comission(price:, rental_days:)
    total_fee = price * 0.3
    insurance = (total_fee * 0.5).to_i
    assistance = (rental_days * @daily_inssurance).to_i
    drivy_fee = (total_fee - insurance - assistance).to_i

    {
      insurance: insurance,
      assistance: assistance,
      drivy_fee: drivy_fee,
    }
  end

  def calculate_rental_prices
    @result = @rentals.map do |rental|
      rental_days = total_rental_days(rental["start_date"], rental["end_date"])
      car = get_car(rental["car_id"])
      price = total_price(car: car,
                          rental_days: rental_days,
                          distance: rental["distance"]).to_i

      commission = calculate_comission(price: price, rental_days: rental_days)
      { id: rental["id"], price: price, commission: commission }
    end
  end
end

GetArroundService.new

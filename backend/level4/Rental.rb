require "json"
require "date"

class Rental
  attr_reader :actions

  def initialize(car:, start_date:, end_date:, distance:)
    @car = car
    @fee = 0.3
    @driver_fee = 1 - @fee
    @distance = distance
    @rental_days = total_rental_days(start_date, end_date)
    @total = total_price
    @daily_inssurance = 100
    @actions = []
  end

  def run
    apply_debits
    apply_credits
  end

  def total_rental_days(start_date, end_date)
    (Date.parse(end_date).mjd - Date.parse(start_date).mjd) + 1
  end

  def time_price
    (1..@rental_days).map do |day|
      discount = if day > 1 && day <= 4
          0.90
        elsif day > 4 && day <= 10
          0.70
        elsif day > 10
          0.50
        else
          1
        end
      discount * @car["price_per_day"]
    end.reduce(:+)
  end

  def distance_price
    @car["price_per_km"] * @distance
  end

  def total_price
    time_price.to_i + distance_price.to_i
  end

  def apply_credits
    apply_credit(who: "owner", amount: (@total * @driver_fee).to_i)

    total_fee = (@total * 0.3).to_i
    insurance = (total_fee * 0.5).to_i
    assistance = (@rental_days * @daily_inssurance).to_i
    drivy_fee = (total_fee - insurance - assistance).to_i

    apply_credit(who: "insurance", amount: insurance)
    apply_credit(who: "assistance", amount: assistance)
    apply_credit(who: "drivy", amount: drivy_fee)
  end

  def apply_debits
    @actions << {
      who: "driver",
      type: "debit",
      amount: @total,
    }
  end

  def apply_credit(who:, amount:)
    @actions << {
      who: who,
      type: "credit",
      amount: amount,
    }
  end
end

# frozen_string_literal: true

require 'date'
require_relative 'prices'

# Module that handles calculation and tracking of shipment discounts
# based on size, carrier, and monthly discount limits.
module DiscountRules
  @monthly_discounts = Hash.new(0.0)
  @lp_large_count = Hash.new(0)

  def self.reset
    @monthly_discounts.clear
    @lp_large_count.clear
  end

  def self.calculate_discount(date, size, carrier)
    year_month = date.strftime('%Y-%m')
    base_price = PRICES[carrier][size]
    discount, reduced_price = size_based_discount(year_month, size, carrier, base_price)
    discount, reduced_price = apply_monthly_discount_limit(year_month, discount, reduced_price, base_price)

    @monthly_discounts[year_month] += discount
    [reduced_price.round(2), discount.round(2)]
  end

  def self.size_based_discount(year_month, size, carrier, base_price)
    case size
    when 'S' then small_size_discount(base_price)
    when 'L' then large_size_discount(year_month, carrier, base_price)
    else [0.0, base_price]
    end
  end

  def self.small_size_discount(base_price)
    lowest_s_price = PRICES.values.map { |p| p['S'] }.min
    discount = base_price - lowest_s_price
    reduced_price = lowest_s_price
    [discount, reduced_price]
  end

  def self.large_size_discount(year_month, carrier, base_price)
    discount = 0.0
    reduced_price = base_price

    if carrier == 'LP'
      @lp_large_count[year_month] += 1
      if @lp_large_count[year_month] == 3
        discount = base_price
        reduced_price = 0.0
      end
    end

    [discount, reduced_price]
  end

  def self.apply_monthly_discount_limit(year_month, discount, reduced_price, base_price)
    total_discount_so_far = @monthly_discounts[year_month]

    if total_discount_so_far + discount > 10.0
      discount = [0.0, 10.0 - total_discount_so_far].max
      reduced_price = base_price - discount
    end

    [discount, reduced_price]
  end
end

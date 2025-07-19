require 'date'
require_relative 'prices'

module DiscountRules
  @monthly_discounts = Hash.new(0.0)
  @lp_large_count = Hash.new(0)

  def self.reset
    @monthly_discounts.clear
    @lp_large_count.clear
  end

  def self.calculate_discount(date, size, carrier)
    ym = date.strftime('%Y-%m')
    base_price = PRICES[carrier][size]
    discount = 0.0
    reduced_price = base_price

    if size == 'S'
      lowest_s_price = PRICES.values.map { |p| p['S'] }.min
      discount = base_price - lowest_s_price
      reduced_price = lowest_s_price

    elsif size == 'L' && carrier == 'LP'
      @lp_large_count[ym] += 1
      if @lp_large_count[ym] == 3
        discount = base_price
        reduced_price = 0.0
      end
    end

    total_discount_so_far = @monthly_discounts[ym]
    if total_discount_so_far + discount > 10.0
      puts total_discount_so_far + discount
      discount = [0.0 , 10.0 - total_discount_so_far].max
      reduced_price = base_price - discount
    end

    @monthly_discounts[ym] += discount
    [reduced_price.round(2), discount.round(2)]
  end
end




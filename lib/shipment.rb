require 'date'
require_relative 'discount_rules'

class Shipment
  attr_reader :date, :size, :carrier, :reduced_price, :discount, :valid, :ignored

  VALID_SIZES = ['S', 'M', 'L'].freeze
  VALID_CARRIERS = ['LP', 'MR'].freeze

  def initialize(line)
    @line = line.strip
    @valid = parse_line
    if @valid
      @reduced_price, @discount = DiscountRules.calculate_discount(@date, @size, @carrier)
    end
  end

  def parse_line
    parts = @line.split
    return false unless parts.size == 3

    date_str = parts[0]
    size = parts[1]
    carrier = parts[2]

    begin
      @date = Date.iso8601(date_str)
    rescue ArgumentError
      return false
    end

    return false unless VALID_SIZES.include?(size)
    return false unless VALID_CARRIERS.include?(carrier)

    @size = size
    @carrier = carrier

    true
  end

  def to_s
    if !@valid
      "#{@line} Ignored"
    else
      discount_str = @discount > 0 ? format('%.2f', @discount) : '-'
      reduced_price_str = format('%.2f', reduced_price)
      "#{@date} #{@size} #{@carrier} #{reduced_price_str} #{discount_str}"
    end
  end
end
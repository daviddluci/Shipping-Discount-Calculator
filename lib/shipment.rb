# frozen_string_literal: true

require 'date'
require_relative 'discount_rules'

# Represents a shiptment with date, size and courrier.
# Parses a shipment line, checks it validity,
# and calculates price and discount.
class Shipment
  attr_reader :date, :size, :carrier, :reduced_price, :discount, :valid, :ignored

  VALID_SIZES = %w[S M L].freeze
  VALID_CARRIERS = %w[LP MR].freeze

  def initialize(line)
    @line = line.strip
    @valid = parse_line
    return unless @valid

    @reduced_price, @discount = DiscountRules.calculate_discount(@date, @size, @carrier)
  end

  def parse_line
    parts = @line.split
    return false unless parts.size == 3

    date_str, size, carrier = parts

    return false unless valid_date?(date_str)
    return false unless VALID_SIZES.include?(size)
    return false unless VALID_CARRIERS.include?(carrier)

    @size = size
    @carrier = carrier

    true
  end

  def valid_date?(date_str)
    @date = Date.iso8601(date_str)
    true
  rescue ArgumentError
    false
  end

  def to_s
    if !@valid
      "#{@line} Ignored"
    else
      discount_str = @discount.positive? ? format('%.2f', @discount) : '-'
      reduced_price_str = format('%.2f', reduced_price)
      "#{@date} #{@size} #{@carrier} #{reduced_price_str} #{discount_str}"
    end
  end
end

# frozen_string_literal: true

require 'minitest/autorun'
require 'date'
require_relative '../lib/discount_rules'
require_relative '../lib/prices'

class DiscountRulesTest < Minitest::Test
  def setup
    DiscountRules.reset
  end

  def test_small_size_discount
    date = Date.iso8601('2025-07-20')
    reduced_price, discount = DiscountRules.calculate_discount(date, 'S', 'MR')

    expected_price = PRICES.values.map { |p| p['S'] }.min

    assert_equal expected_price, reduced_price
    assert_includes [0.0, PRICES['MR']['S'] - expected_price], discount
  end

  def test_large_size_discount
    date = Date.iso8601('2024-07-20')

    2.times do
      DiscountRules.calculate_discount(date, 'L', 'LP')
    end

    reduced_price, discount = DiscountRules.calculate_discount(date, 'L', 'LP')

    assert_equal reduced_price, 0.0
    assert_equal discount, PRICES['LP']['L']
  end

  def test_monthly_discount_limit
    date = Date.iso8601('2023-07-20')

    3.times do
      DiscountRules.calculate_discount(date, 'L', 'LP')
    end

    6.times do
      DiscountRules.calculate_discount(date, 'S', 'MR')
    end

    reduced_price, discount = DiscountRules.calculate_discount(date, 'S', 'MR')

    assert_equal reduced_price, 1.9
    assert_equal discount, 0.1
  end
end

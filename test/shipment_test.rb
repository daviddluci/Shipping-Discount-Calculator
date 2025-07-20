# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/shipment'

class ShipmentTest < Minitest::Test
  def test_valid_shipment_parsing
    shipment = Shipment.new('2025-07-20 S LP')

    assert shipment.valid
    assert_equal 'S', shipment.size
    assert_equal 'LP', shipment.carrier
  end

  def test_invalid_date_shipment_parsing
    shipment = Shipment.new('2015-02-29 L MR')

    assert !shipment.valid
  end

  def test_empty_string_shipment_parsing
    shipment = Shipment.new('')

    assert !shipment.valid
  end
end

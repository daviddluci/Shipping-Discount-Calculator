# frozen_string_literal: true

require_relative 'lib/shipment'
require_relative 'lib/discount_rules'

def process_file(filename)
  DiscountRules.reset
  File.foreach(filename) do |line|
    shipment = Shipment.new(line)
    puts shipment
  end
end

if ARGV.empty?
  puts 'No input file provided. Usage: ruby main.rb input.txt'
  exit 1
end

process_file(ARGV[0])

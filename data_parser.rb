#!/usr/bin/env ruby

require './planet_express_data_parser'

if File.identical?("./data_parser.rb", $0)

  if ARGV.empty?
    puts "Please enter csv to be parsed as a parameter."
    exit
  else
    planet_express = Parse.new
    planet_express.parse_data("#{ARGV[0]}")
  end

end

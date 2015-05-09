#!/usr/bin/env ruby

# ### Deliverables
#
# * A repo containing at least:
#   * `planet_express_logs.csv`
#   * `data_parser.rb`
#   * A Class "Delivery", with the data in the CSV file
#
# ### Requirements
#
#
# * I should be able to run `ruby data_parser.rb` and see the output on the screen
#
# ## Normal Mode
#
# **Good news Rubyists!**
# We have a week of records tracking what we shipped at Planet Express.  I need you to answer a few questions for Hermes.
#
# 1. How much money did we make this week?
# 2. Also, bonuses are paid to employees who pilot the Planet Express
# 3. How many trips did each employee pilot?
# 5. Define and use a class for each shipment
#
# * Different employees have favorite destinations they always pilot to
# * Fry - pilots to Earth (because he isn't allowed into space)
# * Amy - pilots to Mars (so she can visit her family)
# * Bender - pilots to Uranus (teeheee...)
# * Leela - pilots everywhere else because she is the only responsible one
# * They get a bonus of 10% of the money for the shipment as the bonus
# * How much of a bonus did each employee get?

require './planet_express_delivery'
require './planet_express_delivery_person'
require './planet_express_data_parser'

# class Planet
#   attr_accessor :name, :deliveries_to, :money_earned
#
#   def initialize name
#     self.name = name
#   end
# end

if File.identical?("./data_parser.rb", $0)

  if ARGV.empty?
    puts "Please enter csv to be parsed as a parameter."
    exit
  end

  delivery_people = [
    fry = DeliveryPerson.new('Fry'),
    amy = DeliveryPerson.new('Amy'),
    bender = DeliveryPerson.new('Bender'),
    leela = DeliveryPerson.new('Leela')
  ]

  deliveries = []
  CSV.foreach("./#{ARGV[0]}", headers: true) do |line|
    deliveries << Delivery.new(line.to_hash)
  end

  money_made_in_week = deliveries.map do |delivery|
    delivery.money_made
  end.reduce(:+)
  puts "Total money made this week: #{money_made_in_week}."

  deliveries.each do |delivery|
    if delivery.destination == 'earth'
      fry.calculate_deliveries_bonus delivery.money_made
    elsif delivery.destination == 'mars'
      amy.calculate_deliveries_bonus delivery.money_made
    elsif delivery.destination == 'uranus'
      bender.calculate_deliveries_bonus delivery.money_made
    else
      leela.calculate_deliveries_bonus delivery.money_made
    end
  end

  delivery_people.each do |delivery_person|
    puts "#{delivery_person.name} made #{delivery_person.deliveries_made} deliveries this week and made #{delivery_person.bonus} in bonus."
  end

  # ## Hard Mode
  #
  # * Define a class "Parse", with a method `parse_data`, with an argument `file_name`
  #   and outputs the information to the console
  # * How much money did we make broken down by planet? ie.. how much did we make shipping to Earth? Mars? Saturn? etc.
  #
  #

  planet_express = Parse.new
  planet_express.parse_data("#{ARGV[0]}")

end

# ## Nightmare Mode
#
# * No methods can be longer than 10 lines long
# * Make `data_parser.rb executable` with a command line argument of the file name
#
# > `./data_parser.rb planet_express_logs.csv`
#
#
# ## Notes
#
# File name: `planet_express_logs.csv`
# Record format:
#
# > Destination, What got shipped, Number of crates, Money we made
#
# ```ruby
# require 'csv'
# CSV.foreach("planet_express_logs.csv", headers: true) do |line|
#   puts line.inspect # replace with your logic
# end
# ```
#
# ## Additional Resources
#
# * Read []()

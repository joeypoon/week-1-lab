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

require 'csv'

class Delivery
  attr_accessor :destination, :shipment_item, :number_of_crates, :money_made

  def initialize hash
    self.destination = hash['Destination'].downcase
    self.shipment_item = hash[' What got shipped'].downcase
    self.number_of_crates = hash[' Number of crates'].to_f
    self.money_made = hash[' Money we made'].to_f
  end
end

class DeliveryPerson
  attr_accessor :name, :deliveries_made, :bonus

  def initialize (name, deliveries = 0, bonus = 0)
    self.name = name
    self.deliveries_made = deliveries
    self.bonus = bonus
  end

  def calculate_bonus money
    self.bonus = bonus + (money * 0.1)
  end
end

delivery_people = [
  fry = DeliveryPerson.new('Fry'),
  amy = DeliveryPerson.new('Amy'),
  bender = DeliveryPerson.new('Bender'),
  leela = DeliveryPerson.new('Leela')
]

#lstrip!
deliveries = []
CSV.foreach("./planet_express_logs.csv", headers: true) do |row|
  deliveries << Delivery.new(row.to_hash)
end

money_made_in_week = deliveries.map do |delivery|
  delivery.money_made
end.reduce(:+)
puts "Total money made this week: #{money_made_in_week}."

deliveries.each do |delivery|
  if delivery.destination == 'earth'
    fry.deliveries_made = fry.deliveries_made + 1
    fry.bonus = fry.calculate_bonus delivery.money_made
  elsif delivery.destination == 'mars'
    amy.deliveries_made = amy.deliveries_made + 1
    amy.bonus = amy.calculate_bonus delivery.money_made
  elsif delivery.destination == 'uranus'
    bender.deliveries_made = bender.deliveries_made + 1
    bender.bonus = bender.calculate_bonus delivery.money_made
  else
    leela.deliveries_made = leela.deliveries_made + 1
    leela.bonus = leela.calculate_bonus delivery.money_made
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
# CSV.foreach("planet_express_logs.csv", headers: true) do |row|
#   puts row.inspect # replace with your logic
# end
# ```
#
# ## Additional Resources
#
# * Read []()

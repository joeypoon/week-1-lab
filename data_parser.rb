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
    self.destination = hash['Destination']
    self.shipment_item = hash['What got shipped']
    self.number_of_crates = hash['Number of crates']
    self.money_made = hash['Money we made']
  end
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

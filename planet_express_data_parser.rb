# ## Hard Mode
#
# * Define a class "Parse", with a method `parse_data`, with an argument `file_name`
#   and outputs the information to the console
# * How much money did we make broken down by planet? ie.. how much did we make shipping to Earth? Mars? Saturn? etc.
#

class Parse
  require_relative 'planet_express_delivery'
  require 'csv'

  attr_accessor :planet, :planets

  def initialize
    destinations = 'earth, mars, moon, uranus, jupiter, pluto, saturn, mercury'.split(', ')
    self.planets = destinations.map do |planet|
      {planet: planet, revenue: 0}
    end
  end

  def parse_data file_name
    CSV.foreach("./#{file_name}", headers: true) do |line|
      self.planets.each do |planet|
        if line.to_hash['Destination'].downcase == planet[:planet]
          planet[:revenue] = planet[:revenue] + line.to_hash[' Money we made'].to_f
        end
      end
    end
    revenue_by_planet self.planets
  end

  private

    def revenue_by_planet planets
      planets.each do |planet|
        puts "We made #{planet[:revenue]} from #{planet[:planet].capitalize} this week."
      end
    end

end

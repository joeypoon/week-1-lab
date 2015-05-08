# ## Hard Mode
#
# * Define a class "Parse", with a method `parse_data`, with an argument `file_name`
#   and outputs the information to the console
# * How much money did we make broken down by planet? ie.. how much did we make shipping to Earth? Mars? Saturn? etc.
#

class Parse
  require_relative 'planet_express_delivery'
  require 'csv'

  attr_accessor :planet

  def parse_data file_name
    destinations = 'earth, mars, moon, uranus, jupiter, pluto, saturn, mercury'.split(', ')

    planets = []
    destinations.each do |planet|
      planets << {planet: planet, revenue: 0}
    end

    CSV.foreach("./#{file_name}", headers: true) do |line|
      planets.each do |planet|
        if line.to_hash['Destination'].downcase == planet[:planet]
          planet[:revenue] = planet[:revenue] + line.to_hash[' Money we made'].to_f
        end
      end
    end

    planets.each do |planet|
      puts "We made #{planet[:revenue]} from #{planet[:planet].capitalize} this week."
    end
    # planets = deliveries.map do |delivery|
    #   {planet: delivery.destination, revenue: delivery.money_made}
    # end
    #
    # planets.each do |planet|
    #   earth = {}
    # end
  end

end



#hash.merge(hash2 { |key, old_val, new_val| new_val + old_val })

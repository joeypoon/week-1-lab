class Parse
  require './planet_express_delivery'
  require './planet_express_delivery_person'
  require 'csv'

  attr_accessor :deliveries, :delivery_people, :planets

  def initialize
    self.deliveries = []
    self.delivery_people = []
    self.planets = 'Earth, Moon, Mars, Uranus, Jupiter, Pluto, Saturn, Mercury'.split(", ")
  end

  def parse_data file_name
    set_deliveries file_name
    create_crew
    display_data
  end

  private

  def display_data
    puts "We made #{weekly_earnings} this week"
    self.delivery_people.each do |person|
      puts "* #{person.name} made #{person.deliveries} and earned #{person.bonus} in bonus"
    end
    self.planets.each { |planet| puts "* #{planet}: #{earnings_for(planet)}" }
  end

  def set_deliveries file_name
    CSV.foreach("./#{file_name}", headers: true) do |line|
      self.deliveries << Delivery.new(line.to_hash)
    end
  end

  def deliveries_for planet
    self.deliveries.select { |delivery| planet == delivery.destination }
  end

  def earnings_for planet
    deliveries_for(planet).map { |delivery| delivery.money_made }.reduce(:+)
  end

  def weekly_earnings
    self.deliveries.map { |delivery| delivery.money_made }.reduce(:+)
  end

  def set_deliverer name, planets
    person = DeliveryPerson.new name
    planets.each do |planet|
      person.deliveries = person.deliveries + deliveries_for(planet).count
    end
    planets.each do |planet|
      person.add_bonus(earnings_for(planet))
    end
    self.delivery_people << person
  end

  def create_crew
    set_deliverer('Fry', ['Earth'])
    set_deliverer('Amy', ['Mars'])
    set_deliverer('Bender', ['Uranus'])
    set_deliverer('Leela', ['Moon', 'Jupiter', 'Pluto', 'Saturn', 'Mercury'])
  end
end

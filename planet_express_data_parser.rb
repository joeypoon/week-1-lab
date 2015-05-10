class Parse
  require './planet_express_delivery'
  require './planet_express_delivery_person'
  require './planet'
  require 'csv'

  attr_accessor :planets, :delivery_people, :deliveries, :revenue_per_planet

  def initialize
    set_planets
    set_delivery_people
  end

  def parse_data file_name
    set_deliveries file_name
    display_data
  end

  private

    def display_data
      puts
      puts "We made #{weekly_revenue} this week"
      puts
      display_bonus_and_deliveries
      puts
      display_revenue_by_planet
      puts
    end

    def set_deliveries file_name
      self.deliveries = []
      CSV.foreach("./#{file_name}", headers: true) do |line|
        self.deliveries << Delivery.new(line.to_hash)
      end
    end

    def set_planets
      self.planets = [
        earth = Planet.new('Earth'),
        mars = Planet.new('Mars'),
        moon = Planet.new('Moon'),
        uranus = Planet.new('Uranus'),
        jupiter = Planet.new('Jupiter'),
        pluto = Planet.new('Pluto'),
        saturn = Planet.new('Saturn'),
        mercury = Planet.new('Mercury')]
    end

    def set_delivery_people
      self.delivery_people = {
        fry: DeliveryPerson.new('Fry'),
        amy: DeliveryPerson.new('Amy'),
        bender: DeliveryPerson.new('Bender'),
        leela: DeliveryPerson.new('Leela')
      }
    end

    def weekly_revenue
      self.deliveries.map do |delivery|
        delivery.money_made
      end.reduce(:+)
    end

    def display_bonus_and_deliveries
      sort_deliveries_by_planet
      set_deliveries_and_bonuses
      self.delivery_people.each do |key, value|
        puts "* #{value.name.capitalize} made #{value.deliveries_made} deliveries this week and made #{value.bonus} in bonus."
      end
    end

    def sort_deliveries_by_planet
      self.planets.each do |planet|
        self.deliveries.each do |delivery|
          if delivery.destination == planet.name
            planet.deliveries = planet.deliveries + 1
            planet.revenue = planet.revenue + delivery.money_made
          end
        end
      end
    end

    def set_deliveries_and_bonuses
      self.planets.each do |planet|
        if planet.name == 'earth'
          self.delivery_people[:fry].calculate_deliveries_bonus planet
        elsif planet.name == 'mars'
          self.delivery_people[:amy].calculate_deliveries_bonus planet
        elsif planet.name == 'uranus'
          self.delivery_people[:bender].calculate_deliveries_bonus planet
        else
          self.delivery_people[:leela].calculate_deliveries_bonus planet
        end
      end
    end

    def display_revenue_by_planet
      self.planets.each do |planet|
        puts "* #{planet.name.capitalize}: #{planet.revenue}"
      end
    end
end

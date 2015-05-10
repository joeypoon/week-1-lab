class DeliveryPerson
  attr_accessor :name, :deliveries_made, :bonus

  def initialize name
    self.name = name.downcase
    self.deliveries_made = 0
    self.bonus = 0
  end

  def calculate_deliveries_bonus planet
    bonus_percent = 0.10
    self.deliveries_made = deliveries_made + planet.deliveries
    self.bonus = bonus + (planet.revenue * bonus_percent)
  end
end

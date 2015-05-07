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

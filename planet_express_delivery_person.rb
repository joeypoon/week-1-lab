class DeliveryPerson
  attr_accessor :name, :deliveries, :bonus

  def initialize name
    self.name = name.downcase.capitalize
    self.deliveries = 0
    self.bonus = 0
  end

  def add_bonus revenue
    bonus_percent = 0.10
    self.bonus = (bonus + (revenue * bonus_percent)).to_i
  end
end

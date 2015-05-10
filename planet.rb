class Planet
  attr_accessor :name, :deliveries, :revenue

  def initialize name
    self.name = name.downcase
    self.deliveries = 0
    self.revenue = 0
  end
end

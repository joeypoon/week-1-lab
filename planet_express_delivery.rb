class Delivery
  attr_accessor :destination, :shipment_item, :number_of_crates, :money_made

  def initialize hash
    self.destination = hash['Destination'].downcase
    self.shipment_item = hash[' What got shipped'].downcase
    self.number_of_crates = hash[' Number of crates'].to_f
    self.money_made = hash[' Money we made'].to_f
  end
end

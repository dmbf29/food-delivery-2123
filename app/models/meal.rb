class Meal
  attr_reader :name, :price
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @name = attributes[:name] # string
    @price = attributes[:price] # integer
  end
end

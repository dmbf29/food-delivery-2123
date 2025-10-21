class Order
  attr_accessor :id
  attr_reader :meal, :customer, :employee

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # INSTANCE
    @customer = attributes[:customer] # INSTANCE
    @employee = attributes[:employee] # INSTANCE
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def undelivered?
    @delivered == false
  end

  def deliver!
    @delivered = true
  end
end

# Order.new(meal: random_instance, delivered: true)
# Order.new(delivered: false)
# order = Order.new
# order.meal = random_instance_of_meal

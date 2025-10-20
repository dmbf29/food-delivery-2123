require_relative "../views/customer_view"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customer_view = CustomerView.new
  end

  def list
    # get all the customers from the repository
    customers = @customer_repository.all
    # pass the customers to the view to display
    @customer_view.display(customers)
  end

  def add
    # Ask the view to ask the user for a name
    name = @customer_view.ask_for("name")
    # Ask the view to ask the user for a price
    address = @customer_view.ask_for("address")
    # Make an instance of customer
    customer = Customer.new(name: name, address: address)
    # ask the repository to store the instance (in the array/csv)
    @customer_repository.create(customer)
  end
end

require_relative '../views/employee_view'
require_relative '../views/order_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @employee_view = EmployeeView.new
    @order_view = OrderView.new
  end

  def add
    # get all the meals from the meal repository
    # tell the meal view to display the meals
    # ask the user for the index (aka what number)
    # get the one meal from the meals array using the index
    meals = @meal_repository.all
    @meal_view.display(meals)
    index = @meal_view.ask_for('number').to_i - 1
    meal = meals[index]

    # get all the customers from the customer repository
    # tell the customer view to display the customers
    # ask the user for the index (aka what number)
    # get the one customer from the customers array using the index
    customers = @customer_repository.all
    @customer_view.display(customers)
    index = @customer_view.ask_for('number').to_i - 1
    customer = customers[index]

    # get all the riders from the employee repository
    # tell the employee view to display the employees
    # ask the user for the index (aka what number)
    # get the one employee from the employees array using the index
    employees = @employee_repository.all_riders
    @employee_view.display(employees)
    index = @employee_view.ask_for('number').to_i - 1
    employee = employees[index]

    # create an instance of an order (w/ meal, customer, rider)
    p order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    # give the instance to the repository
    @order_repository.create(order)
  end

  def list_undelivered_orders
    # get all the undelivered orders from the order repo
    # give the orders to the view
    orders = @order_repository.undelivered_orders
    @order_view.display(orders)
  end

  def list_my_undelivered_orders(employee)
    orders = @order_repository.my_undelivered_orders(employee)
    @order_view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.my_undelivered_orders(employee)
    @order_view.display(orders)
    # tell the view to ask for the number aka the index
    index = @order_view.ask_for('number').to_i - 1
    # get the order from the orders array using the index
    order = orders[index]
    # mark that one order as delivered
    @order_repository.mark_as_delivered(order)
  end
end

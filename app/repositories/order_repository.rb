require "csv"
require_relative "../models/order"

class OrderRepository
  def initialize(csv_filepath, meal_repository, customer_repository, employee_repository)
    @csv_filepath = csv_filepath
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@csv_filepath)
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def create(order) # order instance as a parameter
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def find(id)
    @orders.find do |order|
      order.id == id
    end
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def load_csv
    # row has IS the attributes hash
    CSV.foreach(@csv_filepath, headers: :first_row, header_converters: :symbol) do |attributes|
      # transform all the data into the correct data type
      attributes[:id] = attributes[:id].to_i
      attributes[:meal] = @meal_repository.find(attributes[:meal_id].to_i)
      attributes[:customer] = @customer_repository.find(attributes[:customer_id].to_i)
      attributes[:employee] = @employee_repository.find(attributes[:employee_id].to_i)
      attributes[:delivered] = attributes[:delivered] == 'true'
      # Make a order instance
      order = Order.new(attributes)
      # Insert the instance into the @orders array
      @orders << order
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_csv
    CSV.open(@csv_filepath, "wb") do |csv|
      csv << ["id", "meal_id", "customer_id", "employee_id", "delivered"]
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end
end

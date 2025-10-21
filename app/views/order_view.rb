class OrderView
  def display(orders)
    if orders.any?
      orders.each_with_index do |order, index|
        puts "#{index + 1} - #{order.meal.name} - #{order.meal.price}
        Customer: #{order.customer.name} @ #{order.customer.address}
        Rider: #{order.employee.username}"
      end
    else
      puts "No orders yet."
    end
  end

  def ask_for(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end
end

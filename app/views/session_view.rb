class SessionView
  def ask_for(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end

  def welcome(employee)
    puts "Welcome #{employee.username}!"
  end

  def wrong_credentials
    puts "Sorry wrong credentials."
  end
end

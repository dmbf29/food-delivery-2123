require_relative '../views/session_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @session_view = SessionView.new
  end

  # handle user actions -> CRUD

  def login
    # tell the view to ask for username
    # get the username from the user
    username = @session_view.ask_for('username')
    # tell the view to ask for password
    # get the password from the user
    password = @session_view.ask_for('password')
    # ask the repository for the employee with the username
    employee = @employee_repository.find_by_username(username)
    # check if the password of the empoyee is the same as the one given
    # if the password is the same -> welcome message
    # if the password is NOT the same -> say wrong credentials, login again
    if employee && employee.password == password
      @session_view.welcome(employee)
      return employee # give the router the employee who just logged in
    else
      @session_view.wrong_credentials
      login
    end
  end
end

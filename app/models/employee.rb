class Employee
  attr_reader :id, :username, :role, :password

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @role = attributes[:role] # string
    @username = attributes[:username] # string
    @password = attributes[:password] # string
  end

  def manager?
    @role == 'manager'
  end

  def rider?
    @role == 'rider'
  end
end

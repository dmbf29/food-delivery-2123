require "csv"
require_relative "../models/employee"

class EmployeeRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @employees = []
    load_csv if File.exist?(@csv_filepath)
  end

  def all
    @employees
  end

  def find_by_username(username)
    @employees.find do |employee|
      employee.username == username
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_filepath, headers: :first_row, header_converters: :symbol) do |row|
      # transform all the data into the correct data type
      row[:id] = row[:id].to_i
      # Make a employee instance
      employee = Employee.new(row)
      # Insert the instance into the @employees array
      @employees << employee
    end
  end
end

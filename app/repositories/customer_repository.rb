require "csv"
require_relative "../models/customer"

class CustomerRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_filepath)
  end

  def all
    @customers
  end

  def create(customer) # customer instance as a parameter
    # p customer
    customer.id = @next_id
    @next_id += 1
    # p customer
    @customers << customer
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_filepath, headers: :first_row, header_converters: :symbol) do |row|
      # transform all the data into the correct data type
      row[:id] = row[:id].to_i
      # Make a customer instance
      customer = Customer.new(row)
      # Insert the instance into the @customers array
      @customers << customer
    end
    @next_id = @customers.last.id + 1 unless @customers.empty?
  end

  def save_csv
    CSV.open(@csv_filepath, "wb") do |csv|
      csv << ["id", "name", "address"]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end

require "csv"
require_relative "../models/meal"

class MealRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_filepath)
  end

  def all
    @meals
  end

  def create(meal) # meal instance as a parameter
    # p meal
    meal.id = @next_id
    @next_id += 1
    # p meal
    @meals << meal
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_filepath, headers: :first_row, header_converters: :symbol) do |row|
      # transform all the data into the correct data type
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      # Make a meal instance
      meal = Meal.new(row)
      # Insert the instance into the @meals array
      @meals << meal
    end
    @next_id = @meals.last.id + 1 unless @meals.empty?
  end

  def save_csv
    CSV.open(@csv_filepath, "wb") do |csv|
      csv << ["id", "name", "price"]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end

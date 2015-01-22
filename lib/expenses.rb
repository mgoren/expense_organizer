class Expense

  attr_reader(:name, :cost, :date, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @cost = attributes.fetch(:cost)
    @date = attributes.fetch(:date)
    @id = attributes[:id]
  end

  define_singleton_method(:total_cost) do
    total_cost = 0.0
    Expense.all().each() do |expense|
      total_cost += expense.cost()
    end
    total_cost
  end

  define_method(:==) do |another_expense|
    self.id() == another_expense.id()
  end

  define_singleton_method(:all) do
    expenses = []
    returned_expenses = DB.exec("SELECT * FROM expenses ORDER BY date;")
    returned_expenses.each() do |expense|
      name = expense.fetch("name")
      cost = expense.fetch("cost").to_f()
      date = expense.fetch("date")
      id = expense.fetch("id").to_i()
      expenses.push(Expense.new({ :name => name, :cost => cost, :date => date, :id => id }))
    end
    expenses
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO expenses (name, cost, date) VALUES ('#{@name}', #{@cost}, '#{@date}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    DB.exec("UPDATE expenses SET name = '#{@name}' WHERE id = #{self.id()};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM categories_expenses WHERE expense_id = #{self.id()};")
    DB.exec("DELETE FROM expenses WHERE id = #{self.id()};")
  end

  define_method(:assign_category) do |category|
    DB.exec("INSERT INTO categories_expenses (category_id, expense_id) VALUES (#{category.id()}, #{self.id()});")
  end

  define_method(:categories) do
    categories = []
    returned_categories = DB.exec("SELECT categories.* FROM expenses JOIN categories_expenses ON (expenses.id = categories_expenses.expense_id) JOIN categories ON (categories_expenses.category_id = categories.id) WHERE expenses.id = #{self.id()};")
    returned_categories.each() do |category_hash|
      id = category_hash.fetch('id').to_i()
      name = category_hash.fetch('name')
      categories.push(Category.new({ :name => name, :id => id }))
    end
    categories
  end


end

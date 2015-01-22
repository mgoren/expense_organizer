class Category

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  define_method(:==) do |another_category|
    self.id() == another_category.id()
  end

  define_singleton_method(:all) do
    categories = []
    returned_categories = DB.exec("SELECT * FROM categories ORDER BY name;")
    returned_categories.each() do |category|
      name = category.fetch("name")
      id = category.fetch("id").to_i()
      categories.push(Category.new({ :name => name, :id => id }))
    end
    categories
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO categories (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    DB.exec("UPDATE categories SET name = '#{@name}' WHERE id = #{self.id()};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM categories_expenses WHERE category_id = #{self.id()};")
    DB.exec("DELETE FROM categories WHERE id = #{self.id()};")
  end

  define_method(:expenses) do
    expenses = []
    returned_expenses = DB.exec("SELECT expenses.* FROM expenses JOIN categories_expenses ON (expenses.id = categories_expenses.expense_id) JOIN categories ON (categories.id = categories_expenses.category_id) WHERE categories.id = #{self.id()};")
    returned_expenses.each() do |expense_hash|
      id = expense_hash.fetch('id').to_i()
      name = expense_hash.fetch('name')
      cost = expense_hash.fetch('cost').to_f()
      date = expense_hash.fetch('date')
      expenses.push(Expense.new({ :id => id, :name => name, :cost => cost, :date => date }))
    end
    expenses
  end

  define_method(:total_cost) do
    total_cost = 0.0
    self.expenses().each() do |expense|
      total_cost += expense.cost() * expense.category_share(self)
    end
    total_cost
  end

  define_method(:percent_total) do
    self.total_cost() / Expense.total_cost()
  end

end

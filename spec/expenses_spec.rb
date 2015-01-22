require('spec_helper')

describe(Expense) do

  describe('.total_cost') do
    it("returns total cost of all Expense objects") do
      test_expense = Expense.new({ :name => "coffee", :cost => 2.50, :date => "2015-01-22" })
      test_expense.save()
      test_expense2 = Expense.new({ :name => "cheeseburger", :cost => 4, :date => "2015-01-21"})
      test_expense2.save()
      expect(Expense.total_cost()).to(eq(6.5))
    end
  end

  describe('#==') do
    it("returns as equal when expenses names and IDs match") do
      expense1 = Expense.new({ :name => "coffee", :cost => 2.50, :date => "2015-01-22" })
      expense1.save()
      expense1_from_db = Expense.all.first()
      expect(expense1).to(eq(expense1_from_db))
    end
  end

  describe('.all') do
    it("returns empty at first") do
      expect(Expense.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("saves expense into db") do
      expense1 = Expense.new({ :name => "coffee", :cost => 2.50, :date => "2015-01-22" })
      expense1.save()
      expect(Expense.all()).to(eq([expense1]))
    end
  end

  describe('#update') do
    it("will update the name of a expense") do
      test_expense = Expense.new({ :name => "coffee", :cost => 2.50, :date => "2015-01-22" })
      test_expense.save()
      test_expense.update({:name => "cheeseburger"})
      expect(test_expense.name()).to(eq("cheeseburger"))
    end
  end

  describe("#delete") do
    it("lets you delete a expense from the database") do
      test_expense = Expense.new({ :name => "coffee", :cost => 2.50, :date => "2015-01-22" })
      test_expense.save()
      test_expense2 = Expense.new({ :name => "cheeseburger", :cost => 4, :date => "2015-01-21"})
      test_expense2.save()
      test_expense.delete()
      expect(Expense.all()).to(eq([test_expense2]))
    end
  end

  describe('#assign_category') do
    it("lets you assign a category to an expense") do
      test_expense = Expense.new({ :name => "coffee", :cost => 2.50, :date => "2015-01-22" })
      test_expense.save()
      test_category = Category.new({ :name => "food"})
      test_category.save()
      test_expense.assign_category(test_category)
      expect(test_expense.categories()).to(eq([test_category]))
    end
  end





end

require('spec_helper')

describe(Category) do

  describe('#==') do
    it("returns as equal when categories names and IDs match") do
      category1 = Category.new({ :name => "food" })
      category1.save()
      category1_from_db = Category.all().first()
      expect(category1).to(eq(category1_from_db))
    end
  end

  describe('.all') do
    it("returns empty at first") do
      expect(Category.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("saves category into db") do
      category1 = Category.new({ :name => "food" })
      category1.save()
      expect(Category.all()).to(eq([category1]))
    end
  end

  describe('#update') do
    it("will update the name of a category") do
      test_category = Category.new({ :name => "food" })
      test_category.save()
      test_category.update({:name => "fast food"})
      expect(test_category.name()).to(eq("fast food"))
    end
  end

  describe("#delete") do
    it("lets you delete a category from the database") do
      test_category = Category.new({ :name => "food"})
      test_category.save()
      test_category2 = Category.new({ :name => "fast food"})
      test_category2.save()
      test_category.delete()
      expect(Category.all()).to(eq([test_category2]))
    end
  end

  describe("#expenses") do
    it("returns an array of expense objects matching a given category") do
      test_category = Category.new({ :name => "food"})
      test_category.save()
      test_expense = Expense.new({ :name => "coffee", :cost => 2.50, :date => "2015-01-22" })
      test_expense.save()
      test_expense.assign_category({ :category => test_category })
      test_expense2 = Expense.new({ :name => "cheeseburger", :cost => 4, :date => "2015-01-21"})
      test_expense2.save()
      test_expense2.assign_category({ :category => test_category })
      expect(test_category.expenses()).to(eq([test_expense, test_expense2]))
    end
  end

  describe('#total_cost') do
    it("returns total cost for category it's called on") do
      test_category = Category.new({ :name => "food"})
      test_category.save()
      test_expense = Expense.new({ :name => "coffee", :cost => 2.50, :date => "2015-01-22" })
      test_expense.save()
      test_expense.assign_category({ :category => test_category })
      test_expense2 = Expense.new({ :name => "cheeseburger", :cost => 4, :date => "2015-01-21"})
      test_expense2.save()
      test_expense2.assign_category({ :category => test_category })
      expect(test_category.total_cost()).to(eq(6.5))
    end
  end

  describe('#percent_total') do
    it("returns a decimal representing persent cost for given category relative to all expenses") do
      test_category = Category.new({ :name => "food"})
      test_category.save()
      test_expense = Expense.new({ :name => "coffee", :cost => 3.00, :date => "2015-01-22" })
      test_expense.save()
      test_expense.assign_category({ :category => test_category })
      test_expense2 = Expense.new({ :name => "cheeseburger", :cost => 1.00, :date => "2015-01-21"})
      test_expense2.save()
      expect(test_category.percent_total()).to(eq(0.75))
    end
    it('returns a correct percentage reflecting partial categorization') do
      test_category = Category.new({ :name => "food"})
      test_category.save()
      test_expense = Expense.new({ :name => "coffee", :cost => 3.00, :date => "2015-01-22" })
      test_expense.save()
      test_expense.assign_category({ :category => test_category, :percent => 0.5 })
      test_expense2 = Expense.new({ :name => "cheeseburger", :cost => 1.00, :date => "2015-01-21"})
      test_expense2.save()
      test_expense2.assign_category({ :category => test_category, :percent => 0.5 })
      expect(test_category.percent_total()).to(eq(0.5))
    end
  end

  describe('#company_share') do
    it("what share of this category went to this company") do
      test_company = Company.new({ :name => "Voodoo" })
      test_company.save()
      test_company2 = Company.new({ :name => "Blue Star" })
      test_company2.save()
      test_category = Category.new({ :name => "food"})
      test_category.save()
      test_expense = Expense.new({ :name => "donut", :cost => 4.0, :date => "2015-01-22", :company_id => test_company.id() })
      test_expense.save()
      test_expense2 = Expense.new({ :name => "maple bar", :cost => 4.0, :date => "2015-01-21", :company_id => test_company2.id() })
      test_expense2.save()
      test_expense.assign_category({:category => test_category})
      test_expense2.assign_category({:category => test_category})
      expect(test_category.company_share(test_company)).to(eq(0.50))
    end
    it("what share of this category went to this company") do
      test_company = Company.new({ :name => "Voodoo" })
      test_company.save()
      test_company2 = Company.new({ :name => "Blue Star" })
      test_company2.save()
      test_category = Category.new({ :name => "food"})
      test_category.save()
      test_expense = Expense.new({ :name => "donut", :cost => 4.0, :date => "2015-01-22", :company_id => test_company.id() })
      test_expense.save()
      test_expense2 = Expense.new({ :name => "maple bar", :cost => 2.0, :date => "2015-01-21", :company_id => test_company2.id() })
      test_expense2.save()
      test_expense.assign_category({:category => test_category, :percent => 0.5 })
      test_expense2.assign_category({:category => test_category})
      expect(test_category.company_share(test_company)).to(eq(0.50))
    end
  end
end

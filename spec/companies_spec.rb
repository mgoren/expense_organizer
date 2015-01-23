require('spec_helper')

describe(Company) do

  describe('#==') do
    it("returns as equal when companies names and IDs match") do
      company1 = Company.new({ :name => "Voodoo" })
      company1.save()
      company1_from_db = Company.all.first()
      expect(company1).to(eq(company1_from_db))
    end
  end

  describe('.all') do
    it("returns empty at first") do
      expect(Company.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("saves company into db") do
      company1 = Company.new({ :name => "Voodoo" })
      company1.save()
      expect(Company.all()).to(eq([company1]))
    end
  end

  describe('#update') do
    it("will update the name of a company") do
      test_company = Company.new({ :name => "Voodoo" })
      test_company.save()
      test_company.update({:name => "Blue Star"})
      expect(test_company.name()).to(eq("Blue Star"))
    end
  end

  describe("#delete") do
    it("lets you delete a company from the database") do
      test_company = Company.new({ :name => "Voodoo" })
      test_company.save()
      test_company2 = Company.new({ :name => "Blue Star" })
      test_company2.save()
      test_company.delete()
      expect(Company.all()).to(eq([test_company2]))
    end
  end




end

class Company

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  define_method(:==) do |another_company|
    self.id() == another_company.id()
  end

  define_singleton_method(:all) do
    companies = []
    returned_companies = DB.exec("SELECT * FROM companies ORDER BY name;")
    returned_companies.each() do |company|
      name = company.fetch("name")
      id = company.fetch("id").to_i()
      companies.push(Company.new({ :name => name, :id => id }))
    end
    companies
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO companies (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    DB.exec("UPDATE companies SET name = '#{@name}' WHERE id = #{self.id()};")
  end

  define_method(:delete) do
    DB.exec("UPDATE expenses SET company_id = NULL WHERE company_id = #{self.id()};")
    DB.exec("DELETE FROM companies WHERE id = #{self.id()};")
  end

  define_singleton_method(:find) do |id|
    Company.all().each() do |company|
      if company.id().==(id)
        return company
      end
    end
  end




end

require('rspec')
require('pg')
require('pry')
require('./lib/expenses')
require('./lib/categories')
require('./lib/companies')

DB = PG.connect({ :dbname => 'expense_organizer_test' })

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses *;")
    DB.exec("DELETE FROM categories *;")
    DB.exec("DELETE FROM categories_expenses *;")
    DB.exec("DELETE FROM companies *;")
  end
end

require('pg')

DB = PG.connect({:dbname => "Guest"})

db_name = "expense_organizer"
db_name_test = (db_name + "_test")
###############################################


table1_name = "expenses"
column1 = "name"
column1_type = "varchar"
column2 = "cost"
column2_type = "float"
column3 = "date"
column3_type = "date"
column4 = "company_id"
column4_type = "int"

table2_name = "categories"
table2_column1 = "name"
table2_column1_type = "varchar"

table3_name = "categories_expenses"
table3_column1 = "category_id"
table3_column1_type = "int"
table3_column2 = "expense_id"
table3_column2_type = "int"
table3_column3 = "percent"
table3_column3_type = "float"

table4_name = "companies"
table4_column1 = "name"
table4_column1_type = "varchar"


DB.exec("CREATE DATABASE #{db_name};")

#disconnect from Guest database and connect to our new one
DB2 = PG.connect({:dbname => db_name})
DB2.exec("CREATE TABLE #{table1_name} (id serial PRIMARY KEY, #{column1} #{column1_type}, #{column2} #{column2_type}, #{column3} #{column3_type}, #{column4} #{column4_type});")
DB2.exec("CREATE TABLE #{table2_name} (id serial PRIMARY KEY, #{table2_column1} #{table2_column1_type});")
DB2.exec("CREATE TABLE #{table3_name} (id serial PRIMARY KEY, #{table3_column1} #{table3_column1_type}, #{table3_column2} #{table3_column2_type}, #{table3_column3} #{table3_column3_type});")
DB2.exec("CREATE TABLE #{table4_name} (id serial PRIMARY KEY, #{table4_column1} #{table4_column1_type});")

#create our test database
DB2.exec("CREATE DATABASE #{db_name_test} WITH TEMPLATE #{db_name};")

###############################################

#or comment out all between the two lines of pound signs above, and delete some databases
# DB.exec("DROP DATABASE #{db_name};")
# DB.exec("DROP DATABASE #{db_name_test};")


# <3 Dan 2015 danwright.co

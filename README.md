Expense Organizer
=================

by Gabe Finch and Mike Goren

Expense Organizer is a set of classes and methods for tracking expenses, including associating expenseses with categories and companies.

Installation
------------

Install Expense Organizer by first cloning the repository.  
```
$ git clone http://github.com/mgoren/expense_organizer.git
```

Install all of the required gems:
```
$ bundle install
```

Start the database:
```
$ postgres
```

Create the databases and tables by running the following:
```
$ ruby database_create.rb
```

License
-------

GNU GPL v2. Copyright 2015 Gabe Finch and Mike Goren

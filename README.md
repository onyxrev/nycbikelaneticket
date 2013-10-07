NYC Bike Lane Ticket
====================

http://www.nycbikelaneticket.com

This web application exists to collect the information of those who have been ticketed in New York City for riding outside of a bicycle lane.  The goal of this collection is to provide the foundation for a class action lawsuit against the City of New York.  These "failure to use the bike lane" tickets are most likely not legally sound but fighting them individually often costs more than the the fine.  We will be more effective together.

This application was written in Ruby on Rails 4.0

Getting Started
----------------

If you want to deploy this app it's basically the standard Rails dance:

Install dependencies:
* database - MySQL, PostgreSQL, etc
* ruby
* bundler

```bash
bundle install
rake db:setup
rails s
```

That aught to get you going.

Tests were written in Rspec and Capybara.

```bash
rspec spec
rspec spec/features
```

License
-------

License is MIT.  Please open issues or fix bugs you find.  Thanks!

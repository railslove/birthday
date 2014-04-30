# Birthday [![Build Status](https://secure.travis-ci.org/railslove/birthday.png)](http://travis-ci.org/railslove/birthday)

This is a small gem that hooks into ActiveRecord and allows to tag a database field (date or datetime) as birthday, allowing to find birthdays with ease. 

## How To Install

To install this gem, fire this command from your terminal:

    gem install birthday

or add this line to your Gemfile:

    gem 'birthday', '~> 0.3.0'

## Synopsis

After installing this gem, you are able to work with anniversaries, such as birthdays in such a manner:

    class User < ActiveRecord::Base

      acts_as_birthday :birthday

    end

Add `acts_as_birthday :field_name` to your ActiveRecord model (or symbols for multiple fields, if you need to), and right away you can access methods:

* `birthday_age` - which will calculate current anniversary/age from the point in time,
* `birthday_today?` - which will return true or false, depending on whether the anniversary happens today.

### Created instance methods

If you add more fields to `acts_as_birthday` method, like:

    acts_as_birthday :birthday, :anniversary, :something_else

it will automatically create methods: `birthday_age`, `birthday_today?`, `anniversary_age`, `anniversary_today?`, `something_else_age`, `something_else_today?`.

### Created scopes

On top of that you get useful scopes: `birthday_today`, `find_birthdays_for`, `anniversary_today`, `find_anniversaries_for`, `something_else_today`, and `find_something_elses_for`.

These scopes accept maximum of two parameters, which have to respond to method `to_date` (by default objects of class Date, Time and DateTime). Thanks to these now you can search for birthdays...

* today:

        # Let's say today is April 24th:
        > User.birthday_today
         => [#<User id: 56, birthday: "1976-04-24">]

* on a specific date:

        > User.find_birthdays_for(Date.parse('04-04-2000'))
         => [#<User id: 23, birthday: "1961-04-04">, #<User id: 34, birthday: "1985-04-04">]

* between a specific range:

        > User.find_birthdays_for(Date.parse('04-04-2000'), Date.parse('05-04-2000'))
         => [#<User id: 23, birthday: "1961-04-04">, #<User id: 34, birthday: "1985-04-04">, #<User id: 56, birthday: "1976-04-24">, #<User id: 57, birthday: "1958-04-30">, #<User id: 60, birthday: "1986-05-04">]

* and even at the turn of the years:

        # This will search for birthdays between 12.12 and 3.01
        > User.find_birthdays_for(Date.parse('12-12-2000'), Date.parse('03-01-2001'))
         => [#<User id: 1, birthday: "1961-12-14">, #<User id: 12, birthday: "1985-12-15">, #<User id: 25, birthday: "1961-12-24">, #<User id: 27, birthday: "1985-01-01">, #<User id: 40, birthday: "1961-01-02">]

Since all these are essentially scopes, there's nothing stopping you from chaining them with other scopes:

    class User < ActiveRecord::Base

      acts_as_birthday :birthday

      scope :admins, {:is_admin => true}
      scope :named_like, lambda { |name| { :conditions => [ "first_name LIKE :q OR email LIKE :q OR last_name LIKE :q", { :q => "%#{name}%" } ] } }

    end


    > User.admins.named_like("Mike").find_birthdays_for(Date.parse('12-12-2000'), Date.parse('03-01-2001'))

### Your own adapters

At this moment, this gem supports MySQL, PostgreSQL and SQLite databases. If you want to support another type of database, you can write your own adapter.

You can create your own birthday adapters for the ORM adapters we're not supporting yet by writing a class with a class method `scope_hash`, which will return a hash normally used in `active_record` scopes.

    module Railslove
      module Acts
        module Birthday
          module Adapter
            class SqliteAdapter
              def self.scope_hash(field, date_start, date_end)
                # do some magic and return scope hash you can use
                # field is the field used in the database
                # date_start and date_end can be anything that responds to .to_date method
              end
            end
          end
        end
      end
    end

With this namespacing (`Railslove::Acts::Birthday::Adapter`) and naming the class after `active_record`'s ORM adapter (like `SqliteAdapter` in the example above) you can automatically use your own adapters with this gem.

If you happen to write one of the adapters, don't hesitate to [make a pull request](https://github.com/railslove/birthday/pull/new/master)! You will help the whole Ruby community with it!

### To do

* kick class_eval?

## Note on Patches/Pull Requests

* Fork the project.
* Create a feature branch
* Make your feature addition or bug fix.
* Add tests.
* Commit, do not mess with Rakefile, version, or history.
* Send me a pull request.

## Changelog

* [v0.2.0](https://github.com/railslove/birthday/compare/v0.1.1...v0.2.0)
  * added `*field*_today` scopes to quickly look up anniversaries for today (acts like `find_*field*s_for(Date.today)`)

* [v0.1.1](https://github.com/railslove/birthday/compare/v0.1.0...v0.1.1)
  * fixed autoloading of `Adapter` class in Rails 2 environment
  * updated README to include examples

* [v0.1.0](https://github.com/railslove/birthday/compare/v0.0.2...v0.1.0)
  * big batch of refactoring (still no changes in availalbe methods)

* [v0.0.2](https://github.com/railslove/birthday/compare/v0.0.1...v0.0.2)
  * moving custom adapter definition from `acts_as_birthday` method params to a separate scope
  * first batch of refactoring (no changes in available methods)

* v0.0.1
  * initial version

## Copyright

Copyright (c) 2011 Railslove

## Main contributors

* [@Holek (Mike Połtyn)](http://github.com/Holek)
* [@Bumi (Michael Bumann)](http://github.com/bumi)

## External links

* [Railslove blog post about the usage of this gem](http://blog.railslove.com/2011/10/17/birthday-gem-easy-anniversaries-handling-ruby/)
* [Rubygems.org site for `birthday` gem](http://rubygems.org/gems/birthday)

## License

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

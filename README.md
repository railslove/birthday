# Birthday

This is a small gem that hooks into ActiveRecord and allows to tag a database field (date or datetime) as birthday, allowing to find birthdays with ease.

## How To Install

After the gem has been properly tested, it will be released on RubyGems, and will be available to be installed with:

    gem install birthday

or in your Gemfile:

    gem 'birthday', '~> 0.0.2'

## Synopsis

Read [a blog post about the gem](http://blog.railslove.com/2011/10/17/birthday-gem-easy-anniversaries-handling-ruby/) at Railslove blog to get a comprehensive guide to usage of this gem.

You can create your own adapters for the ORM adapters we're not supporting yet by writing a class with a class method `scope_hash`, which will return a hash normally used in `active_record` scopes.

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

### To do

* kick class_eval?
* make tests more "aware" of environment

## Note on Patches/Pull Requests

* Fork the project.
* Create a feature branch
* Make your feature addition or bug fix.
* Add tests.
* Commit, do not mess with Rakefile, version, or history.
* Send me a pull request.

## Copyright

Copyright (c) 2011 Railslove

## Main contributors

* [@Holek (Mike Połtyn)](http://github.com/Holek)
* [@Bumi (Michael Bumann)](http://github.com/bumi)

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

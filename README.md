# Birthday

This is a small gem that hooks into ActiveRecord and allows to tag a database field (date or datetime) as birthday, allowing to find birthdays with ease.

## How To Install

After the gem has been properly tested, it will be released on RubyGems, and will be available to be installed with:

    gem install birthday


Until then, you have to either clone a git repository and build the gem yourself, or add this line to your Gemfile:

    gem 'birthday', :git => 'git://github.com/railslove/birthday.git'

## Synopsis

Will update readme as soon as possible. Until then, look into the [self-explanatory tests](https://github.com/railslove/birthday/blob/master/spec/birthday_spec.rb) (and `schema.rb`)

This gem is not release-ready yet.

### To do

* Test PostgreSQL
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

Copyright (c) 2011 Mike Połtyn

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
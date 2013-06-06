# UCB Rails

[![Gem Version](https://badge.fury.io/rb/ucb_rails.png)](http://badge.fury.io/rb/ucb_rails)
[![Build Status](https://travis-ci.org/stevedowney/ucb_rails.png)](https://travis-ci.org/stevedowney/ucb_rails)
[![Coverage Status](https://coveralls.io/repos/stevedowney/ucb_rails/badge.png?branch=master)](https://coveralls.io/r/stevedowney/ucb_rails?branch=master)
[![Code Climate](https://codeclimate.com/github/stevedowney/ucb_rails.png)](https://codeclimate.com/github/stevedowney/ucb_rails)

Get a jump start on your Rails project at UCB.  Includes:

* CalNet authentication with [omniauth-cas](https://github.com/dlindahl/omniauth-cas)
* LDAP integration with [ucb_ldap](https://rubygems.org/gems/ucb_ldap)
* includes several other gems including:
  * [bootstrap-view-helpers](https://github.com/stevedowney/bootstrap-view-helpers)
  * [user_announcements](https://github.com/stevedowney/user_announcements)
  * [rails_environment](https://github.com/stevedowney/rails_environment)

## Installation

Add it to your Gemfile

```ruby
gem 'ucb_rails'

# bleeding edge
gem 'ucb_rails', git: 'https://github.com/stevedowney/ucb_rails'
```

From the command line, install the `ucb_rails` gem:

```sh
bundle install
rails g ucb_rails:install
```

Run installers for included gems:

```sh
rails generate user_announcements:install
rails generate simple_form:install --bootstrap
```

Run migrations:

```sh
rake db:migrate
```

Remove superseded files:

```sh
rm public/index.html
rm app/views/layouts/application.html.erb  
```

Restart your server and point your browser to:

```
http://<your_app>/ucb_rails
```

You'll be able to CalNet authenticate.  Successful authentiation will redirect
you to `root_path`.  `ucb_rails` defines `root_path` but the definition in your
host app (if any) will take precedence.


## View Helper Methods

* `current_ldap_person`
* `logged_in?`
 


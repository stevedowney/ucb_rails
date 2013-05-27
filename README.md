# UCB Rails

Get a jump start on your Rails project at UCB.  Includes:

* CalNet authentication with [omniauth-cas](https://github.com/dlindahl/omniauth-cas)
* LDAP integration with [ucb_ldap](https://rubygems.org/gems/ucb_ldap)
* includes several other gems including:
  * [rails_environment](https://github.com/stevedowney/rails_environment)

## Installation

Add it to your Gemfile

```ruby
gem install 'ucb_rails'
```

From the command line:

```sh
$ bundle install
$ rails g ucb_rails:install
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
 


# TODO

* add #active column to users

* login authorization
  * CalNet Authenticated
  * in 'people'
  * in user table (and active)
  * custom login authorization
  * via UI, change login rules (i.e., admin only)
  
* steps in README
  * warnings about files
  * run other installers (list)
  * rake db:migrate
  
* exception notification
  * include gem
  * include configuration (where)
  * force error controller
  
* post generator install message
  * group :development do
      gem 'rack-mini-profiler'
    end

* authorization
  * cancan?
  * roles support

* previous/next record support

* strategy for extending ucb_rails
  * new class that subclasses
  * have an empty module included that can be overriden
## Creating Rails Project

### Initialization

```sh
# List available rubies, to choose which ruby to use
$ rvm list rubies

# To install new ruby use, for example version '2.4.1'
$ rvm install 2.4.1

# create and use the new RVM gemset for project "my_app"
$ rvm use --create 2.4.1@my_app

# install latest rails into the blank gemset
$ gem install rails

# Creates new rails app "my_app"
# -d mysql: defining database
# -T to skip generating test folder and files (in case of planning to use rspec)
rails new my_app -d mysql -T

# go into the new project directory and create a .ruby-version and .ruby-gemset for the project
$ cd my_app
$ rvm --ruby-version use 2.4.1@my_app

# initialize git
$ git init
$ git add .
$ git commit -m 'new rails app'
$ git remote add origin git@git.x.com:x/my_app.git
$ git push -u origin master
```

### Gems

#### Haml and Bootstrap

```ruby
gem 'haml-rails'
gem 'bootstrap-generators' # to generate views using bootstrap
```

```sh
$ rake haml:erb2haml
$ rails generate bootstrap:install --template-engine=haml
```
#### Devise and OmniAuth

```ruby
gem 'devise', '~> 3.4'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-instagram'
gem 'twitter'
gem 'instagram'
gem 'omniauth-google-oauth2'
gem 'google-api-client', require: 'google/api_client'
gem 'devise-bootstrap-views' # to generate bootstrap devise views
```

```sh
$ rails g devise:views:bootstrap_haml_templates
$ rails g scaffold User name role:integer
$ rails generate devise User

# Edit database.yml to match your configuration
$ rake db:create db:migrate
```

### Others

* For devise and other authentication options checkout this See [link](http://willschenk.com/setting-up-devise-with-twitter-and-facebook-and-other-omniauth-schemes-without-email-addresses/).
* To setup testing checkout this See [link](http://willschenk.com/setting-up-testing/).

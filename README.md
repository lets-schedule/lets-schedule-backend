# Let's Schedule (Backend)

This is the backend of the Let's Schedule application. This part of the
application is implemented with Ruby on Rails and will communicate with the
front end of the application via the REST api. Specifically, the backend will
respond to user requests by making database queries regarding user log in
information and viewing and/or editing user calendars. 

Directory Structure:
- `app/`: contains core application code (controllers, models, views, helpers, mailers, channels, jobs, and assets)
- `bin/`: contains binary executable files (scripts) to start, update, deploy, or run your Rails app
- `config/`: contains the configuration files for the application, routes, database, etc.
- `db/`: contains database files, database schema, and database migrations
- `lib/`: contains extended library modules
- `log/`: contains the application log files
- `public/`: contains data that is accessible via browsers (static files, compiled assets, error pages, etc.)
- `storage/`: contains active storage files
- `test/`: contains application unit tests, fixtures, and various other test apparatus
- `tmp/`: contains temporary files (like cache and pid files)
- `vendor/`: contains any third party code
- `Gemfile`: contains the gem requirements for the application, required for Ruby to run the app
- `Gemfile.lock`: contains a list of gems to ensure all copies of the application use the same version
- `Rakefile`: allows the command line to locate and run rake tasks (a Make-like build utility implemented in Ruby for task automation)
- `config.ru`: contains configuration for the Rack middleware based servers used to start the application
- `package.json`: allows you to specify npm dependencies for your Rails app

### Required Source Code:

- To access the _Let's Schedule Frontend_ clone its repository via this
  instruction: `git clone git@github.com:lets-schedule/lets-schedule-frontend.git`

All software dependencies are automatically downloaded and installed when
`$ bundle install` is called

### Sofware Building

1. download and install ruby
2. download and install ruby on rails using the command `$ gem install rails`
3. execute `$ bundle install` command to download and install dependencies
   automatically
4. migrate database schema with `$ rails db:migrate`
5. start server with `$ rails server`

### Testing

Refer to the [Ruby on Rails testing documentation](https://guides.rubyonrails.org/testing.html)

Run all tests with the `$ rails test` command

Run a single test by feeding the name of the file and test as an argument

i.e. `$ rails test test/models/task_test.rb -n test_task_create`

Testing can be accomplished in a number of ways. Testing individual components
of the program can be accomplished by creating [fixtures](https://api.rubyonrails.org/v3.1/classes/ActiveRecord/Fixtures.html) which act as example data to be used in `test/models` tests and `./test/controllers/` tests

Alternatively, one can use `curl` to create HTTP requests to test the behavior
of the program. This is useful to demonstrate connectivity with an outside
source.

Note: it is important to run the `$ rails db:migrate ENV=test` to ensure that
the test environment database matches that of the development environment. 

New `Task` tests should be added to:
- `./test/controllers/task_controller_test.rb` or `./test/models/task_test.rb`
New 'Event' tests should be added to:
- `./test/controllers/event_controller_test.rb` or `./test/models/event_test.rb`
New 'Constraint' tests should be added to:
- `./test/controllers/constraint_controller_test.rb` or `./test/models/constraint_test.rb`



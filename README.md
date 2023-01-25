# lets-schedule-backend

This is the backend of the Let's Schedule application. This part of the
application is implemented with Ruby on Rails and will communicate with the
front end of the application via the REST api. Specifically, the backend will
respond to user requests by making database queries regarding user log in
information and viewing and/or editing user calendars. 

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

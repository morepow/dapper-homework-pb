# Requirements
Ensure Ruby 2.7.5 is installed, I recommend using rbenv or RVM to manage your Ruby Versions

# Installation
Clone the project, load Ruby in you console and run the following command:
```
bundle install
```

Make sure that you have postgres installed and running, and create a user with the ability to create a database.

Copy the file '.env.sample' to '.env', and provide your credentials in that file.

Run the following command to populate the database schema:

```
bundle exec rake db:create db:migrate
```

Finally, run the following command to start the server:

```
bundle exec rails s
```

# Usage
You can use the OpenAPI Web Interface with any of the unauthenticated endpoints like '/login' and '/signup' Navigate to the following URL in you browser:

```
http://localhost:3000/api-docs/index.html
```

For authenticated endpoints, you will need to use CURL and provide the authentication header as follows:

```
curl -X GET "http://localhost:3000/api/v1/users" -H  "accept: application/json" -H "x-authentication-token: <<JWT_TOKEN>>"
```

# Running Tests
You can run the unit tests as well by running the following command to migrtate the test database:

```
RAILS_ENV=test bundle exec rake db:create db:migrate
```

Then run the tests with the following command:

```
bundle exec rspec
```

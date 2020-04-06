# Books API

[![Build Status](https://travis-ci.org/yusent/jobsity_books.svg?branch=master)](https://travis-ci.org/yusent/jobsity_books)
[![Coverage Status](https://coveralls.io/repos/github/yusent/jobsity_books/badge.svg?branch=master)](https://coveralls.io/github/yusent/jobsity_books?branch=master)

## Install & Run

### Using Docker Compose
```shell
$ docker-compose up
```

### Locally
Ruby 2.6.6 was used. I recommend using [rvm](https://rvm.io) to handle the environment.
```shell
$ bundle install
$ bundle exec rails db:migrate
$ bundle exec rails server
```

## Testing
```shell
$ bundle exec rspec
```
For manual testing I recommend using [Postman](https://www.postman.com).

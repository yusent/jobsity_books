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

## Usage

### Using Postman
A Postman collection is available [here](https://www.getpostman.com/collections/f2c000a5ab2a4bb37a1f).

### Using Curl

#### List books
```shell
curl -i -X GET 'http://localhost:3000/api/v1/books'
```

#### Search books by title
```shell
curl -i -X GET 'http://localhost:3000/api/v1/books?title=my%20title'
```

#### Search books by ISBN code
```shell
curl -i -X GET 'http://localhost:3000/api/v1/books?isbn=978-1-64-093054-4'
```

#### Show a book
```shell
curl -i -X GET 'http://localhost:3000/api/v1/books/1'
```

#### Add a new book
```shell
curl -i \
  -X POST \
  -H "Content-type: application/json" \
  -d '{"book": {"title": "The Kybalion", "author": "The three initiates", "isbn": "ISBN-13: 978-1-64-093054-4", "short_description": "A Study of the Hermetic Philosophy", "price": 144.12}}' \
  'http://localhost:3000/api/v1/books'
```

#### Update a book
```shell
curl -i \
  -X PUT \
  -H "Content-type: application/json" \
  -d '{"book": {"title": "The Kybalion", "author": "The three initiates", "isbn": "ISBN-13: 978-1-64-093054-4", "short_description": "A Study of the Hermetic Philosophy", "price": 144.12}}' \
  'http://localhost:3000/api/v1/books/1'
```

#### Remove a book
```shell
curl -i -X DELETE 'http://localhost:3000/api/v1/books/1'
```

## Testing
```shell
$ bundle exec rspec
```
For manual testing I recommend using [Postman](https://www.postman.com).

FROM ruby:2.6.6

# Copy application code
COPY . /application

# Change to the application's directory
WORKDIR /application

# Set environment to production
ENV RAILS_ENV production

# Install gems
RUN bundle install --deployment --without development test \
  && cp config/database.docker.yml config/database.yml \
  && bundle exec rails db:migrate

ENTRYPOINT ["bundle", "exec", "rails", "server"]

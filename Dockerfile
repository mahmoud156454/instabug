FROM ruby:3.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs


WORKDIR /app
COPY Gemfile* ./
RUN bundle install
RUN rails db:migrate
RUN rails db:seed
COPY . .

EXPOSE 3000

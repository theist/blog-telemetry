FROM ruby:2.3

RUN gem install sinatra
RUN gem install statsd-ruby

ADD app.rb /app.rb

EXPOSE 4567
CMD ruby /app.rb

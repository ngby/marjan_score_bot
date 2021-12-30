FROM ruby:2.6.6

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y 
RUN gem install bundler
RUN bundle install

CMD ["ruby", "bot.rb"]
# syntax=docker/dockerfile:1
FROM ruby:2.7.6
RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs default-mysql-client yarn
WORKDIR /myapp 
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
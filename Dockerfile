# Use the official Ruby image with the desired version
FROM ruby:2.7.0

# Set the working directory in the container
WORKDIR /app
RUN gem install bundler:2.3.26
# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the application code into the container
COPY . .

# Expose port 3000 (or the port your Rails app is configured to use)
EXPOSE 3000

# Start the Rails application
#CMD ["rails", "server", "-b", "0.0.0.0"]

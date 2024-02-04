From ruby:2.7.0

# RUN apk add build-base mysql-dev

# RUN apk update && apk add imagemagick-dev gcc musl-dev make && \
#   gem install rmagick

RUN bash -c "export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -qq && \
    apt-get -y upgrade && \
    apt-get install -y \
        build-essential \
        git-core \
        locales \
        libcurl4 \
        libgeos-dev \
        libpq-dev \
        postgresql-client \
        wget && \
    apt-get clean && \
    rm -rf /usr/share/doc && \
    rm -rf /var/lib/apt/lists/*"

# Default locale to en_US.UTF-8 so that we can use characters like ß and ü
ENV LANG=en_US.UTF-8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN gem update --system && \
    gem install bundler:2.3.4

RUN mkdir -p /app
WORKDIR /app

# install all the gems in a single layer. We do things this way so that Docker
# can cache the install command (compiling things like Nokogiri)
COPY Gemfile Gemfile.lock /app/
RUN bundle install && \
    rm -rf /usr/local/bundle/cache && \
    rm -rf /root/.bundle/cache

COPY . /app

# # Precompile assets and expose port 3000
EXPOSE 8099

# CMD ["bin/docker-start"]
# CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["rails", "server", "-p", "8099", "-b", "0.0.0.0"]
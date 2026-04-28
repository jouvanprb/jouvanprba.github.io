FROM ruby:3.3.10

# Install dependencies
RUN apt-get update && apt-get install -y build-essential

# Set environment variables for gems
ENV GEM_HOME=/usr/local/bundle
ENV PATH=/usr/local/bundle/bin:$PATH

# Install Jekyll and Bundler
RUN gem install jekyll bundler

# Set working directory
WORKDIR /srv/jekyll

# Expose Jekyll port
EXPOSE 4000

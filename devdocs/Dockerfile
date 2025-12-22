FROM ruby:3.4.7-alpine

# DevDocs repository reference (branch, tag, or commit SHA)
ARG DEVDOCS_REF=main

ENV LANG=C.UTF-8
ENV ENABLE_SERVICE_WORKER=true

WORKDIR /devdocs

# Install system dependencies
RUN apk --update add nodejs build-base libstdc++ gzip git zlib-dev libcurl && \
    gem install bundler

# Clone DevDocs repository and checkout specified ref
RUN git clone https://github.com/freeCodeCamp/devdocs.git . && \
    git checkout ${DEVDOCS_REF} && \
    bundle install --system --without test

# Download only specified documentation sets
# c: C Programming Language
# cpp: C++ Programming Language
# kotlin~1.9: Kotlin 1.9
# openjdk~21: OpenJDK 21
# python~3.9: Python 3.9
RUN thor docs:download c cpp kotlin~1.9 openjdk~21 python~3.9

# Update default_docs configuration to match downloaded docs
# This ensures users see the correct documentation sets on first visit
RUN sed -i "s/set :default_docs, %w(css dom html http javascript)/set :default_docs, %w(c cpp kotlin~1.9 openjdk~21 python~3.9)/" lib/app.rb

# Compile assets
RUN thor assets:compile

# Clean up to reduce image size
RUN apk del gzip build-base git zlib-dev && \
    rm -rf /var/cache/apk/* /tmp ~/.gem /root/.bundle/cache \
    /usr/local/bundle/cache /usr/lib/node_modules

EXPOSE 9292

CMD ["rackup", "-o", "0.0.0.0"]

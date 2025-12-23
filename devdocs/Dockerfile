FROM ruby:3.4.7-alpine

# DevDocs repository reference (branch, tag, or commit SHA)
ARG DEVDOCS_REF=main

ENV LANG=C.UTF-8
ENV ENABLE_SERVICE_WORKER=true

WORKDIR /devdocs

RUN apk --update add nodejs build-base libstdc++ gzip git zlib-dev libcurl && \
    gem install bundler \
    git clone https://github.com/freeCodeCamp/devdocs.git . && \
    git checkout ${DEVDOCS_REF} && \
    bundle install && \
    sed -i "s/set :default_docs, %w(css dom html http javascript)/set :default_docs, %w(c cpp kotlin~1.9 openjdk~21 python~3.9)/" lib/app.rb && \
    RUN thor docs:download c cpp kotlin~1.9 openjdk~21 python~3.9 && \
    thor assets:compile && \
    apk del gzip build-base git zlib-dev && \
    rm -rf /var/cache/apk/* /tmp ~/.gem /root/.bundle/cache \
    /usr/local/bundle/cache /usr/lib/node_modules

EXPOSE 9292
CMD ["rackup", "-o", "0.0.0.0"]

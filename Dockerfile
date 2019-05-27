FROM ruby:2.6.3

RUN apt-get update && apt-get install -y cron \
    software-properties-common && \
    apt-get update && \
    apt-get install -y locales && \
    dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8 && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen

RUN bundle config --global frozen 1

WORKDIR /app
ENV HOME /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler

RUN bundle install

ENV LANG=en_US.UTF-8

ENV HANAMI_HOST=0.0.0.0
ENV HANAMI_ENV=production

EXPOSE 2300

CMD ["./docker-entrypoint.sh"]

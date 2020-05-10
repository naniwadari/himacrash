FROM ruby:2.6.5
RUN apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev \
  nodejs
RUN apt-get install -y vim
RUN mkdir /webapp

ENV APP_ROOT /webapp
WORKDIR ${APP_ROOT}

ADD ./Gemfile ${APP_ROOT}/Gemfile
ADD ./Gemfile.lock ${APP_ROOT}/Gemfile.lock
ADD ./yarn.lock ${APP_ROOT}/yarn.lock

RUN apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN bundle install
RUN yarn install 

ADD . ${APP_ROOT}
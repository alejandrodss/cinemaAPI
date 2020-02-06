FROM ruby:2.6.3
RUN gem install bundler

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

RUN mkdir /cinemaAPI
WORKDIR /cinemaAPI
ENV BUNDLE_PATH /cinemaAPI/.gems
ENV GEM_HOME /cinemaAPI/.gems 

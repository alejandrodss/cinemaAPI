FROM ruby:2.6.3
RUN gem install bundler

RUN mkdir /cinemaAPI
WORKDIR /cinemaAPI
ENV BUNDLE_PATH /cinemaAPI/.gems
ENV GEM_HOME /cinemaAPI/.gems 

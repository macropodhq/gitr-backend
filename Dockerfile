FROM ruby:2.1.5

RUN mkdir -p /log
RUN apt-get update && apt-get install -y nginx-full

ADD nginx.conf /etc/nginx/nginx.conf
RUN nginx -t

ADD Gemfile /gems/Gemfile
ADD Gemfile.lock /gems/Gemfile.lock

WORKDIR /gems
RUN bundle install --deployment --path /gems
ADD . /app
WORKDIR /app
RUN rm -rf log
RUN ln -sf /log

CMD bin/start_container

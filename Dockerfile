FROM ruby:2.1.5

RUN mkdir -p /log
RUN apt-get update && apt-get install -y nginx-full

ADD nginx.conf /etc/nginx/nginx.conf
RUN nginx -t

ADD Gemfile /gems/Gemfile
ADD Gemfile.lock /gems/Gemfile.lock

WORKDIR /gems
RUN bundle install --deployment --path /gems
ADD Procfile /app/Procfile
WORKDIR /app

CMD foreman start -f Procfile

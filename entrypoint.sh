#!/bin/sh

yarn install
rm -f /myapp/tmp/pids/server.pid
bin/rails s -p 3000 -b '0.0.0.0' -e production
bundle exec rails db:migrate
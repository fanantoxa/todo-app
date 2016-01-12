#!/bin/bash

echo "Installing package dependencies"

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

sudo apt-get update

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
dpkg-reconfigure locales en

sudo apt-get install -y git
sudo apt-get install -y postgresql postgresql-client postgresql-contrib libpq-dev

echo "Installing rvm, ruby and bundler"

sudo \curl -sSL https://get.rvm.io | bash

source ~/.rvm/scripts/rvm
type rvm | head -n 1


rvm install 2.2.1
rvm --default use ruby-2.2.1
rvm use ruby-2.2.1

gem install bundler

echo "Configure app"

echo "Creating postgres user:"

sudo -u postgres bash -c "psql -c \"CREATE USER todo_user WITH PASSWORD 'testing';\""




cd /vagrant


echo "Installing gems"

bundle install

echo "Running migrations"

bundle exec rake db:create:all --trace
bundle exec rake db:migrate --trace
bundle exec rake db:migrate --trace RAILS_ENV=test

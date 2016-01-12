#!/bin/bash --login 

echo "Installing dependencies"

sudo apt-get install -y libgmp-dev libpq-dev

cd /vagrant

echo "set for for rails app"
echo "VAGRANT_PORT=0.0.0.0" | sudo tee -a /etc/environment
export VAGRANT_PORT=0.0.0.0

echo "Install ruby v 2.2.1"

rvm install 2.2.1

echo "set as default"
rvm use ruby-2.2.1
rvm --default use ruby-2.2.1
rvm rvmrc warning ignore allGemfiles

echo "configuring postgres"
sudo -u postgres bash -c "psql -c \"CREATE USER todo_user WITH PASSWORD 'testing';\""
sudo -u postgres bash -c "psql -c \"ALTER USER todo_user CREATEDB;\""

echo "Installing gems"

bundle install

echo "Running migrations"

bundle exec rake db:create:all --trace
bundle exec rake db:migrate --trace
bundle exec rake db:migrate --trace RAILS_ENV=test
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


To populate csv data to DB in development and test environments, run following cmds

* Development: 
$ bundle exec rails load_data 

* Test:
$ bundle exec rails load_data RAILS_ENV=test


# README

To populate csv data to DB in development and test environments, run following cmds

* Development: 
$ bundle exec rails load_data 

* Test:
$ bundle exec rails load_data RAILS_ENV=test

API urls,
# GET /details
# POST /details
# GET /details/:id
# PUT /details/:id
# DELETE /details/:id

Example urls for search,
#GET /details?beds_range=4-2&page=1&sq__ft_range=1000-1200&building_type=condo

In above, search parameters that has to be passed are beds_range, building_type, sq__ft_range and page.

* beds_range - it takes only digits or specify range digits like 1 or 1-2 or 2-1 anyway accepted.
* building_type - specify full string value.
* sq__ft_range - it takes only digits or specify range digits like 1000 or 1000-2000 or 2000-1000 anyway accepted.
* page - specify page numbers, each page has 10 records.
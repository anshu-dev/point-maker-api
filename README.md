# README

It is API only Rails App which has included APIs for to perform CRUD operation on point, received from map.

## Ruby version
* 2.6.7

## Rails version
* 6.1.3.1

## Installation

* `git clone https://github.com/anshu-dev/point-maker-api.git` 
* `cd point-maker-web`
* `bundle install`


## Database configuration
* Postgresql is used as database.
* Modify `config/database.yml` with your postgresql setting.
* Run `rails db:create`
* Run `rails db:migrate`

## Running / Development

* `rails s`
* Visit your app at [http://localhost:4200](http://localhost:3000/points).

## Heroku URL
* https://point-maker-api.herokuapp.com/points

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

# Examples

api for long to short (POST)
inp = POST  http://0.0.0.0:3000/urls/long_to_short?long=charmander&domain=www.youtube.com
out = {"domain":"bpGa","short":"CDdyqEG"}

api for short to long
inp = GET  http://0.0.0.0:3000/urls/short_to_long?short=9sGKdAY
out = {"long":"bulbasaur"}

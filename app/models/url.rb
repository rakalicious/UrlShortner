require 'elasticsearch/model'
require 'date'
require 'time'

class Url < ApplicationRecord
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
	after_create :start_async_counter

	validates :long_url , :short_url, presence: true
	#validates :short_url, presence: true
	
  #index_name('urls') 
  settings index: {
    number_of_shards: 1,
    number_of_replicas: 0,
    analysis: {
      analyzer: {
        trigram: {
          tokenizer: 'trigram'
        }
      },
      tokenizer: {
        trigram: {
          type: 'ngram',
          min_gram: 3,
          max_gram: 1000,
          token_chars: ['letter', 'digit']
        }
      }
    } } do
    mapping do
      indexes :short_url, type: 'text', analyzer: 'english' do
      indexes :keyword, analyzer: 'keyword'
      indexes :pattern, analyzer: 'pattern'
      indexes :trigram, analyzer: 'trigram'
    	end
      indexes :long_url, type: 'text', analyzer: 'english' do
      indexes :keyword, analyzer: 'keyword'
      indexes :pattern, analyzer: 'pattern'
      indexes :trigram, analyzer: 'trigram'
    	end
		end
	end

=begin
async counter for number of new short urls created
=end
	def start_async_counter
		CounterWorker.perform_async
	end

=begin
generate random string of specified bit for url
=end
	def self.random_string_for_url(number)
		possible_short = UrlsHelper.random_62bit_string(number)
		while Url.find_by(short_url: possible_short) != nil do
			possible_short = UrlsHelper.random_62bit_string(number)
		end
		return possible_short
	end

=begin
find the short url , given the long url and thge short url
=end
	def self.shorten_url(long_url , long_domain)
		#Rails.cache.clear
    number = 7
		url_var = Url.find_by(long_url: long_url)
    dom = Domain.find_by(domain_name: long_domain)
		if url_var
      return (dom ) + "/" + (url_var.short_url)
		else
			short_domain = Url.find_short_domain(long_domain)
      possible_short = Url.random_string_for_url(number)
      Url.create({:long_url => long_url, :short_url => possible_short })
      return (short_domain)+"/"+(possible_short)
		end
	end

=begin
find the short domain , given the long domain from the given url (admin version)
=end
	def self.find_short_domain(long_domain)
		domain_var = Domain.find_by(domain_name: long_domain)
		if domain_var
			return domain_var.short_domain
		else
      short_domain = Rails.cache.fetch(long_domain , :expires_in => 15.minutes) do
        Domain.find_by(domain_name: "default")
      end
      return short_domain.short_domain
		end
	end

=begin
find long url given short url
=end
	def self.find_long_url(short_url)
		long_url = Rails.cache.fetch(short_url , :expires_in => 5.minutes)
		if long_url
			return long_url
		end
    long_url_var = Url.find_by(short_url: short_url)
		if long_url_var
			long_url = Rails.cache.fetch(short_url , :expires_in => 5.minutes) do
        long_url_var.long_url
      end
      return long_url
		else
      return false
		end
	end

=begin
custom search query for elasticsearch
=end
	def self.search(query)
    field = "long_url.trigram"
    urls = self.__elasticsearch__.search(
    {
      query: {
        bool: {
          must: [{
            term: {
              "#{field}":"#{query}"
            }
          }]
        }
      }
    }).records
    return urls
  end

end

require 'elasticsearch/model'
require 'date'
require 'time'

class Url < ApplicationRecord
	include Elasticsearch::Model
  	include Elasticsearch::Model::Callbacks
	after_create :start

	validates :long_url, presence: true
	validates :short_url, presence: true
	
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
	def start
		CounterWorker.perform_async
	end

=begin
generate random string of specified bit for url
=end
	def self.random_string_for_url(number)
		possible_short = UrlsHelper.random_n_string(7,number)
		while Url.find_by(short_url: possible_short) != nil do
			possible_short = UrlsHelper.random_n_string(7,number)
		end
		return possible_short
	end

=begin
find the short url , given the long url and thge short url
=end
	def self.shorten_url(long_url , long_domain)
		number = 62
		#Rails.cache.clear
		url_var = Url.find_by(long_url: long_url)
		if url_var == nil
			short_domain = Url.find_short_domain_admin(long_domain)
			possible_short = Url.random_string_for_url(number)
			new_entry = Url.create({:long_url => long_url, :short_url => possible_short , :short_domain => short_domain})
			return (short_domain)+"/"+(new_entry.short_url)
		else
			short_url = Rails.cache.fetch(long_url , :expires_in => 5.minutes) do
				a = (url_var.short_domain )
				b = (url_var.short_url)
				a + "/" + b
				end
			return short_url
		end

	end

=begin
find the short domain , given the long domain from the given url (admin version)
=end
	def self.find_short_domain_admin(long_domain)
		domain_var = Domain.find_by(domain_name: long_domain)
		if domain_var == nil
			short_domain = Rails.cache.fetch(long_domain , :expires_in => 15.minutes) do
				Domain.find_by(domain_name: "default")
			end
			return short_domain.short_domain
		else
			return domain_var.short_domain
		end
		
	end

=begin
find long url given short url
=end
	def self.find_long_url(short_url)
		if Url.find_by(short_url: short_url) == nil
			return false
		else
			long_url = Rails.cache.fetch(short_url , :expires_in => 5.minutes) do
				Url.where(short_url: short_url).first.long_url
			end
			return long_url
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

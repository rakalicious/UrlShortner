module DomainsHelper
=begin
get domain name from url
=end	
	def self.get_domain_from_url(url)
		domain_name_entered = url.split('.').first
		if domain_name_entered == "www" || domain_name_entered == "ww" || domain_name_entered == "w" 
		end
		return domain_name_entered
	end
end

class Domain < ApplicationRecord

=begin
new domain entry (admin version)
=end
	def self.new_domain_entry(domain_name , short_domain)
		domain_name_entered = DomainsHelper.get_domain_name_from_url(domain_name)

		domain_by_name = Domain.find_by(domain_name: domain_name_entered)
		if domain_by_name != nil
			return "domain alredy has short domain"
		end

		domain_by_short_domain = Domain.find_by(short_domain: short_domain)
		if domain_by_name != nil
			return "short domain already taken"
		end

		Domain.create(domain_name: domain_name_entered , short_domain: short_domain)
		return "short domain added"

	end

end

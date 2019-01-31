class Domain < ApplicationRecord

=begin
new domain entry (admin version)
=end
  def self.new_domain_entry(domain_name , short_domain)
    domain_name_entered = DomainsHelper.get_domain_name_from_url(domain_name)
    if Domain.find_by(domain_name: domain_name_entered) 
      return "domain alredy has short domain"
    end
    if Domain.find_by(short_domain: short_domain)
      return "short domain already taken"
    end

    Domain.create(domain_name: domain_name_entered , short_domain: short_domain)
    return "short domain added"
  end

end

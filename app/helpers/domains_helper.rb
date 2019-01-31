module DomainsHelper
=begin
get domain name from url
=end    
  def self.get_domain_name_from_url(url)
	url = '/' + url
    domain_name_entered = url.split('.').first
    domain_name_entered = domain_name_entered.split('/').last
    if domain_name_entered == "www" || domain_name_entered == "ww" || domain_name_entered == "w" || domain_name_entered == ""
      domain_name_entered = url.split('.')[1]
    end
    return domain_name_entered
  end
end

class DomainsController < ApplicationController
	def new

	end

	def create_domain
		flash[:error] = ""
		response = Domain.new_domain_entry(params[:domain_name] , params[:short_domain])
		if response == false
			flash[:error] = "domain already taken"
			render domains_new_path
			return
		end
		flash[:error] = "new domain created"
		render domains_new_path
	end
end

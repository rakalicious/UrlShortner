class DomainsController < ApplicationController
  before_action :is_session_over_no, only: []
  before_action :is_session_over_yes, only: [:new]
  
  def new
  end
=begin
enter new domain details by admin
=end
  def create_domain
    response = Domain.new_domain_entry(params[:domain_name] , params[:short_domain])
    if response == false
      flash.now[:error] = "domain already taken"
        render domains_new_path
        return
    end
    flash.now[:error] = "new domain created"
    render domains_new_path
  end
end

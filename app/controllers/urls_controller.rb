class UrlsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_session_over_yes, only: [:new, :convert_long , :convert_short]
  before_action :is_session_over_no, only: []
  before_action :session_timeout, only: [:new, :convert_long, :convert_short]

  include UrlsHelper
  require 'date'
  require 'time'
 
  def new
  end

=begin
api for long to short (POST)
inp = POST  http://0.0.0.0:3000/urls/long_to_short ....... and in body    {"long_url_inp" : "www.youtube.com/charmander"}
out = {"short_domain": "yt.ub",
    "short_url": "1R9ixp3"}
=end
  def long_to_short
    domain_name = DomainsHelper.get_domain_name_from_url(url_params[:long_url_inp])
    @req_ans = Url.shorten_url(url_params[:long_url_inp] , domain_name)
    respond_to do |format|
      if @req_ans == false
        @req_ans = ""
        puts "yahan wahan"
        flash.now[:error] = "Domain not registered"
        format.html {render 'urls/new'}
        format.json {render json: {"error" => "Domain not registered"}, status: :not_found}
      end

      format.html {render 'urls/new'}
      format.json { render json: {"short_domain" => @req_ans.split("/").first , "short_url" => @req_ans.split("/").last}, status: :ok}
    end
  end

=begin
api for short to long
inp = GET  http://0.0.0.0:3000/urls/short_to_long?short_url_inp .... and in body     {"short_url_inp" : "T4NKQPa"}
out = {"long_url":"www.youtube.com/ninetails"}
=end
  def short_to_long
    short_inp = url_params[:short_url_inp]
    if short_inp.include? "/"
      short_inp = short_inp.split("/").second
    end
    @req_ans = Url.find_long_url(short_inp)
    respond_to do |format|
      if @req_ans == false
        @req_ans = ""
        flash.now[:error] = "no such short url"
        format.html {render 'urls/new'}
        format.json {render json: {"error" => "Short url does not exist"}, status: :not_found}
      end
      format.html {render 'urls/new'}
      format.json { render json: {"long_url" => @req_ans}, status: :ok}
    end
  end
=begin
logout button
=end
  def logout
    close_session
  end

<<<<<<< HEAD
  private
    def url_params
      params.permit(:short_url_inp , :long_url_inp)
    end
  
=======
		render 'urls/new'
	end

	#api for long to short (POST)
	#inp = POST  http://0.0.0.0:3000/urls/long_to_short ....... and in body    {"long" : "charmander" ,
										# "domain" : "www.youtube.com"}
	#out = {"domain":"bpGa","short":"CDdyqEG"}


	def long_to_short
		short_url = Url.shorten_url(params[:long] , params[:domain])
		@req_ans = short_url

		if short_url == false
			@req_ans = "something went wrong"
			flash[:error] = "wrong domain"
			return
		end
		#@req_ans = short_domain +"/"+ short_url
		
		if params[:action] == "convert_long"
			flash[:error] = ""
			return @req_ans
		else
			render json: {"domain" => @req_ans.split("/").first , "short" => @req_ans.split("/").last}
		end
	end

	#called when user clicks submit for short to long conversion
	def convert_short
		session_timeout(5)
		if is_session_over_yes == true
			redirect_to users_new_user_path
			return
		end
		short_to_long
		@conv = Conversion.get_conv

		render 'urls/new'
	end

	#api for short to long
	#inp = GET  http://0.0.0.0:3000/urls/short_to_long?short=9sGKdAY
	#out = {"long":"bulbasaur"}
	def short_to_long
		@req_ans = Url.find_long_url(params[:short])

		if @req_ans == false
			flash[:error] = "no such short url"
			@conv = Conversion.get_conv

			render urls_new_path
			return
		end

		if params[:action] == "convert_short"
			flash[:error] = ""
			return @req_ans
		else
			render json: {"long" => @req_ans}
		end
		
	end

	def logout
		close_session
	end
	
>>>>>>> 77cac88de0b570fbffe128483bdb6af5e2d28223
end

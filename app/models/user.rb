class User < ApplicationRecord
  require 'digest/md5'

  validates :username, :password ,:email ,:name ,presence: true
=begin
login using given values
=end
  def self.login_using_credentials(login_params)
    md5_password = Digest::MD5.hexdigest(login_params[:password])
    if User.find_by(username: login_params[:username] , password: md5_password)
      return "logged in"
    else
      return "wrong username or password"
    end
  end 
=begin
signup using given values
=end
  def self.signup_using_credentials(signup_params)
    md5_password = Digest::MD5.hexdigest(signup_params[:password])
    users = User.create({:username => signup_params[:username] , :password => md5_password , :email => signup_params[:email] , :name => signup_params[:fullname]})
    #users.save
  end

=begin
check if username is available
=end
  def self.check_username_available(signup_params)
    if User.find_by(username: signup_params[:username])
      return false
    end
    return true
  end
=begin
check if email is available
=end
  def self.check_email_available(signup_params)
    if User.find_by(email: signup_params[:email])
      return false
    end
    return true
  end
end

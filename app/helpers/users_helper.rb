module UsersHelper
require 'digest/md5'
=begin
checks fields if they are empty
=end
  def check_if_empty(allowed_params) 
    for i in allowed_params.keys
      if allowed_params[i] == ""
        return true
      end
    end
    return false
  end

=begin
password match in signup 
=end
  def check_password_match(signup_params)
    md5_password = Digest::MD5.hexdigest(signup_params[:password])
    md5_confirm_password = Digest::MD5.hexdigest(signup_params[:confirm_password])

    if md5_password == md5_confirm_password
      return true
    end
      return false
  end

  
end

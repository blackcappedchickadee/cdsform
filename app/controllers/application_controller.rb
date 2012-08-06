class ApplicationController < ActionController::Base
  #protect_from_forgery
  
  before_filter :restrict_access
  
  def process_form
  end
  
  private 
  def restrict_access
    whitelisted_ipaddress = Cdsform::Application.config.restrictedip
    whitelist = [whitelisted_ipaddress].freeze
    puts "request.remote_ip = #{request.remote_ip}"
    unless whitelist.include? request.remote_ip
      redirect_to access_denied_path
    end
    
  end
  
end

class InquiryFormController < ApplicationController
  
  require "uri"
  require "net/http"
  
  
  def process_form
    
    recaptch_public = Cdsform::Application.config.recaptchapublic
    recaptch_private = Cdsform::Application.config.recaptchaprivate
    remote_ip_addr = request.remote_ip
    recaptch_url = Cdsform::Application.config.recaptchaurl
    challenge = params[:recaptcha_challenge_field]
    response = params[:recaptcha_response_field]
    #puts "configs --- #{recaptch_public}, #{recaptch_private}, #{remote_ip_addr}, #{recaptch_url}"
    
    name = params[:contactname]
    phone = params[:phonenumber]
    email = params[:email]
    performance_dates = params[:performancedate]
    locations = params[:performancelocation]
    budget = params[:budget]
    additional_comments = params[:comments]
    event_type = "#{params[:radios]} #{params[:otherdesc]}"
    redirect_after_save = params[:redirecturl]
    backurl_failure_recaptcha = params[:backurl]

    params = {'privatekey' => recaptch_private, 'remoteip' => remote_ip_addr,
              'challenge' => challenge, 'response' => response}
              
    x = Net::HTTP.post_form(URI.parse(recaptch_url), params)
    retval = x.body
    
    #REMOVE when done!
    #retval = "true"
    
    if retval.include?("true")
      #collect the form fields and post to database, and then send an email
      inquiry_form = InquiryForm.create(:additional_comments => additional_comments, :budget => budget, :email => email, 
          :event_type => event_type, :locations => locations, :name => name, :performance_dates => performance_dates, :phone => phone)
      inquiry_form.save
      @message = "success"
      redirect_to redirect_after_save
      
    else
      if retval.include?("incorrect-captcha-sol")
        redirect_to backurl_failure_recaptcha
      end
    end
    
  end

end

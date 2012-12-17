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
    puts "configs --- #{recaptch_public}, #{recaptch_private}, #{remote_ip_addr}, #{recaptch_url}"
    
    name = params[:contactname]
    email = params[:email]
    phone = params[:phonenumber]
    performance_dates = params[:performancedate]
    locations = params[:performancelocation]
    budget = params[:budget]
    additional_comments = params[:comments]
    event_type = params[:perftype]   #   "#{params[:radios]} #{params[:otherdesc]}"
    redirect_after_save = params[:redirecturl]
    backurl_failure_recaptcha = params[:backurl]
    backurl_failure_other = params[:backurlother]

    params = {'privatekey' => recaptch_private, 'remoteip' => remote_ip_addr,
              'challenge' => challenge, 'response' => response}
              
    x = Net::HTTP.post_form(URI.parse(recaptch_url), params)
    retval = x.body
    
    puts "recaptcha result #{retval}..."
    
    #REMOVE when done!
    #retval = "true"
    
    if retval.include?("true")
      #collect the form fields and post to database, and then send an email
      inquiry_form = InquiryForm.create(:additional_comments => additional_comments, :budget => budget, :email => email, 
          :event_type => event_type, :locations => locations, :name => name, :performance_dates => performance_dates, :phone => phone)
      inquiry_form.save
      
      #mail the inquiry to recipients
      puts "about to email to recipients"
      InquiryMailer.send_email(inquiry_form).deliver
      puts "just finished emailing recipients"
      
      @message = "success"
      redirect_to redirect_after_save
      
    else
      if retval.include?("incorrect-captcha-sol")
        redirect_to backurl_failure_recaptcha
      else
        redirect_to backurl_failure_other
      end
    end
    
  end

end

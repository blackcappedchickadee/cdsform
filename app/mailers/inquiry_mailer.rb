class InquiryMailer < ActionMailer::Base
  default :to => InquiryEmailList.all.map(&:email_address), 
          :from => ENV['GMAIL_USER_NAME']
  
  def send_email(inquiry_form)

    @inquiry_form = inquiry_form
    
    puts "...testing #{@inquiry_form.name}"
    

    mail(:subject => "Cul de Sax Inquiry",
         :from => ENV['GMAIL_USER_NAME'])
  end
  

end
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Cdsform::Application.initialize!

Cdsform::Application.config.restrictedip = ENV['CDSFORM_ALLOWED_IP_ADDRESS']
Cdsform::Application.config.recaptchaurl = 'http://www.google.com/recaptcha/api/verify'
Cdsform::Application.config.recaptchapublic = ENV['RECAPTCHA_PUBLIC_KEY']
Cdsform::Application.config.recaptchaprivate = ENV['RECAPTCHA_PRIVATE_KEY']


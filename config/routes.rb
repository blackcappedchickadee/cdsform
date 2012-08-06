Cdsform::Application.routes.draw do
  post "inquiry_form/process_form"
  
  match '/access_denied', :to => redirect('/access_denied.html')
  
end

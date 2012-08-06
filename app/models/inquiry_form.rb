class InquiryForm < ActiveRecord::Base
  attr_accessible :additional_comments, :budget, :email, :event_type, :locations, :name, :performance_dates, :phone
end

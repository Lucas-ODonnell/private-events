class Invitation < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :event
  
  enum status: {
    no_response: 1,
    accepted: 2,
    not_coming: 3
  }
end

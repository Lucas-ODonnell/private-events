class Invitation < ApplicationRecord
  belongs_to :attendee
  belongs_to :event
end

class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations, source: :attendee

  validates :title, :description, :location, :start_date, :end_date, presence: true
end

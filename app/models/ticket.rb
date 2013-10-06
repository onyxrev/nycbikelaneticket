class Ticket < ActiveRecord::Base
  extend Enumerize

  geocoded_by :location

  enumerize :hearing_verdict, in: [:guilty, :not_guilty, :stay]
  enumerize :appeal_verdict,  in: [:guilty, :not_guilty, :stay]

  belongs_to :plaintiff

  validates :number, :location, :date, :presence     => true
  validates :number,                   :format       => { :with => /[A-Z|0-9]{10}/ }
  validates :officer_id,               :numericality => { :only_integer => true }
end

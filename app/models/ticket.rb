class Ticket < ActiveRecord::Base
  extend Enumerize

  geocoded_by :location

  enumerize :hearing_verdict, in: [:guilty, :not_guilty, :stay]
  enumerize :appeal_verdict,  in: [:guilty, :not_guilty]

  belongs_to :plaintiff

  validates :number, :location, :date, :presence     => true
  validates :number,                   :format       => { :with => /[A-Z|0-9]{10}/ }
  validates :officer_id,               :numericality => { :only_integer => true }

  before_validation :convert_money

  private

  def convert_dollars_to_cents(dollars)
    dollars.to_s.gsub(/[^0-9|\.]/, "").to_f * 100
  end

  def convert_money
    self.fine_cents     = convert_dollars_to_cents(fine_cents)
    self.expenses_cents = convert_dollars_to_cents(expenses_cents)
  end
end

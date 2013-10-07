class Ticket < ActiveRecord::Base
  extend Enumerize

  geocoded_by :location

  enumerize :hearing_verdict, in: [:guilty, :not_guilty, :stay]
  enumerize :appeal_verdict,  in: [:guilty, :not_guilty]

  belongs_to :plaintiff

  validates :number, :location, :date, :presence     => true
  validates :number,                   :uniqueness   => true
  validates :number,                   :format       => { :with => /[A-Z|0-9]{10}/ }
  validates :officer_id,               :numericality => { :only_integer => true }, :allow_blank => true
  validates :description,              :length     => { :maximum => 2000 }

  before_validation :convert_money
  after_validation  :geocode

  def to_hash(extra_keys = [])
    hash = {
      :created_at => self.created_at,
      :fullname   => self.plaintiff.fullname,
      :date       => self.date,
      :latitude   => self.latitude,
      :longitude  => self.longitude
    }

    return hash
  end

  private

  def convert_dollars_to_cents(dollars)
    return nil if dollars.blank?
    dollars.to_s.gsub(/[^0-9|\.]/, "").to_f * 100
  end

  def convert_money
    if self.fine_cents_changed?
      self.fine_cents     = convert_dollars_to_cents(fine_cents)
    end

    if self.expenses_cents_changed?
      self.expenses_cents = convert_dollars_to_cents(expenses_cents)
    end
  end
end

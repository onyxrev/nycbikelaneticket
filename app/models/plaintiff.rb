class Plaintiff < ActiveRecord::Base
  attr_encrypted :street_address1, :key => PLAINTIFF_ENCRYPTION_KEY
  attr_encrypted :street_address2, :key => PLAINTIFF_ENCRYPTION_KEY
  attr_encrypted :postal_code,     :key => PLAINTIFF_ENCRYPTION_KEY
  attr_encrypted :email,           :key => PLAINTIFF_ENCRYPTION_KEY
  attr_encrypted :phone,           :key => PLAINTIFF_ENCRYPTION_KEY

  has_many :tickets, :dependent => :destroy

  # gonna allow international postal codes because I'm sure tourists
  # got stung too
  validates :postal_code,                                   :length     => { :maximum => 10 }
  validates :email, :postal_code, :fullname, :country_code, :presence   => true
  validates :email,                                         :uniqueness => true
  validates :street_address1, :street_address2, :fullname,  :length     => { :maximum => 300 }
  validates :country_code,                                  :length     => { :is => 2 }
  validates :postal_code,                                   :format     => { :with => /[a-z|A-Z|0-9|\-]+/ }

  def to_hash(extra_keys = [])
    keys_to_include = [:name, :created_at] + extra_keys

    return keys_to_include.reduce({}) do |memo, key|
      memo[key] = self.send(key)
    end
  end
end

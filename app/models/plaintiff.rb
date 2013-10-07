class Plaintiff < ActiveRecord::Base
  attr_encrypted :street_address1, :key => PLAINTIFF_ENCRYPTION_KEY, :attribute => 'street_address1_encrypted'
  attr_encrypted :street_address2, :key => PLAINTIFF_ENCRYPTION_KEY, :attribute => 'street_address2_encrypted'
  attr_encrypted :postal_code,     :key => PLAINTIFF_ENCRYPTION_KEY, :attribute => 'postal_code_encrypted'
  attr_encrypted :email,           :key => PLAINTIFF_ENCRYPTION_KEY, :attribute => 'email_encrypted'
  attr_encrypted :phone,           :key => PLAINTIFF_ENCRYPTION_KEY, :attribute => 'phone_encrypted'

  has_many :tickets, :dependent => :destroy

  # gonna allow international postal codes because I'm sure tourists
  # got stung too
  validates :postal_code,                                   :length     => { :maximum => 10 }
  validates :email, :postal_code, :fullname, :country_code, :presence   => true
  validates :email,                                         :uniqueness => true
  validates :street_address1, :street_address2, :fullname,  :length     => { :maximum => 300 }
  validates :postal_code,                                   :format     => { :with => /[a-z|A-Z|0-9|\-]+/ }

  before_validation :sanitize_phone
  before_save       :create_auth_hash

  def self.generate_auth_hash(email, postal_code)
    # I'm not really worried about MD5 rainbow table attacks or
    # anything for this - just need to make sure the email and postal
    # code match the dencrypted values without actually decrypting all
    # the records just to compare
    return Digest::MD5.hexdigest(Plaintiff.auth_string(email, postal_code))
  end

  def self.auth_string(email, postal_code)
    return "#{email}#{postal_code}"
  end

  def self.for_email_and_postal_code(email, postal_code)
    return Plaintiff.where(:auth_hash => Plaintiff.generate_auth_hash(email, postal_code)).first
  end

  def to_hash(extra_keys = [])
    keys_to_include = [:fullname, :created_at] + extra_keys

    return keys_to_include.reduce({}) do |memo, key|
      memo[key] = self.send(key)
      memo
    end
  end

  protected

  def sanitize_phone
    return if self.phone.blank?

    self.phone = self.phone.gsub(/[^0-9|\+]/, "")
  end

  def create_auth_hash
    binding.pry
    return unless self.email_encrypted_changed? or self.postal_code_encrypted_changed?
    self.auth_hash = Plaintiff.generate_auth_hash(self.email, self.postal_code)
  end
end

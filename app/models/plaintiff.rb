class Plaintiff < ActiveRecord::Base
  attr_encrypted :street_address1, :key => PLANTIFF_ENCRYPTION_KEY
  attr_encrypted :street_address2, :key => PLANTIFF_ENCRYPTION_KEY
  attr_encrypted :postal_code,     :key => PLANTIFF_ENCRYPTION_KEY
  attr_encrypted :email,           :key => PLANTIFF_ENCRYPTION_KEY
  attr_encrypted :phone,           :key => PLANTIFF_ENCRYPTION_KEY
end

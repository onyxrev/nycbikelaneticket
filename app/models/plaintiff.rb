class Plaintiff < ActiveRecord::Base
  attr_encrypted :street_address1, :key => PLAINTIFF_ENCRYPTION_KEY
  attr_encrypted :street_address2, :key => PLAINTIFF_ENCRYPTION_KEY
  attr_encrypted :postal_code,     :key => PLAINTIFF_ENCRYPTION_KEY
  attr_encrypted :email,           :key => PLAINTIFF_ENCRYPTION_KEY
  attr_encrypted :phone,           :key => PLAINTIFF_ENCRYPTION_KEY

  def to_hash(extra_keys = [])
    keys_to_include = [:name, :created_at] + extra_keys

    return keys_to_include.reduce({}) do |memo, key|
      memo[key] = self.send(key)
    end
  end
end

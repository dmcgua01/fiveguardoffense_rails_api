class User
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :encrypted_email, type: String
  field :password, type: String
  field :encrypted_password, type: String
  field :api_key, type: String

  attr_encrypted :email, key: Rails.configuration.email_encryption_key, encode: true
  attr_encrypted :password, key: Rails.configuration.password_encryption_key, encode: true
  attr_encrypted :api_key, key: Rails.configuration.api_key_encryption_key, encode: true

  def authenticated?(password)
    self.password.eql? password
  end
end

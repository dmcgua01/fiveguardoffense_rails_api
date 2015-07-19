class User
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :encrypted_email, type: String
  field :password, type: String
  field :encrypted_password, type: String
  field :api_key, type: String
  field :encrypted_api_key, type: String
  field :is_admin, type: Boolean

  attr_encrypted :email, key: Rails.configuration.email_encryption_key, encode: true
  attr_encrypted :password, key: Rails.configuration.password_encryption_key, encode: true
  attr_encrypted :api_key, key: Rails.configuration.api_key_encryption_key, encode: true

  before_create :generate_api_key

  def authenticated?(password)
    self.password.eql? password
  end

  def has_api_key?(api_key)
    self.api_key.eql? api_key
  end

  def admin?
    self.is_admin
  end

  def generate_api_key
    begin
      self.api_key = SecureRandom.urlsafe_base64
    end while not User.all.select{ |user| user.has_api_key?(api_key) }.empty?
  end
end

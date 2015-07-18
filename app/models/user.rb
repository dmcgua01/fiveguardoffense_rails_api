class User
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :password, type: String

  before_save :encrypt_email
  before_save :encrypt_password

  after_save :decrypt_email
  after_save :decrypt_password

  after_initialize :decrypt_email
  after_initialize :decrypt_password

  protected

  def encrypt_email
    #self.data = [Encryptor.encrypt(:value => self.data, :key => Rails.configuration.encryption_key)].pack('m') unless self.data.blank?
    encrypt(self.email, Rails.configuration.email_encryption_key)
  end

  def decrypt_email
    #self.data = Encryptor.decrypt(:value => self.data.unpack('m').first, :key => Rails.configuration.encryption_key) unless self.data.blank?
    decrypt(self.email, Rails.configuration.email_encryption_key)
  end

  def encrypt_password
    #self.data = [Encryptor.encrypt(:value => self.data, :key => Rails.configuration.encryption_key)].pack('m') unless self.data.blank?
    encrypt(self.password, Rails.configuration.password_encryption_key)
  end

  def decrypt_password
    #self.data = Encryptor.decrypt(:value => self.data.unpack('m').first, :key => Rails.configuration.encryption_key) unless self.data.blank?
    decrypt(self.password, Rails.configuration.password_encryption_key)
  end

  def encrypt(value, key)
    value = [Encryptor.encrypt(value: value, key: key)].pack('m') unless value.blank?
  end

  def decrypt(value, key)
    value = Encryptor.decrypt(value: value.unpack('m').first, key: key) unless value.blank?
  end

end

class User
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :encrypted_email, type: String, encrypted: true
  field :encrypted_password, type: String, encrypted: true

end

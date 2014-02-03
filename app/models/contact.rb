class Contact
  include ActiveModel::Model
  extend  ActsAsTextcaptcha::Textcaptcha

  acts_as_textcaptcha api_key: APP_CONFIG['textcaptcha_api_key'], bcrypt_salt: '$2a$10$SUC4iySmA4UuQcZZ.dOmI.'

  attr_accessor :name, :email, :message

  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :message, presence: true

end
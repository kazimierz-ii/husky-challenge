class User < ApplicationRecord
  has_many :access_tokens
  has_many :invoices

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end

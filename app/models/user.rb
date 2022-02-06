class User < ApplicationRecord
  has_many :access_tokens
  has_many :invoices

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end

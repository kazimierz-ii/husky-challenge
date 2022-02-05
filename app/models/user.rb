class User < ApplicationRecord
  has_many :access_tokens

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end

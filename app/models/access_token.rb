class AccessToken < ApplicationRecord
  SALT = '93hefZI9SBWRPatkPWcLxWyr'.freeze

  class Status
    PENDING  = 'p'
    APPROVED = 'a'
    REVOKED  = 'r'
  end

  belongs_to :user

  scope :pending, -> { where(status: Status::PENDING) }
  scope :approved, -> { where(status: Status::APPROVED) }
  scope :pending_or_approved, -> { where(status: [Status::PENDING, Status::APPROVED]) }

  before_create :set_status_pending
  after_create :set_unique_token_and_send_mail

  def set_status_pending
    self.status = Status::PENDING
  end

  def set_unique_token_and_send_mail
    # Usa ID e o SALT para criar um token unico
    access_token = Base64.strict_encode64("#{id}_#{SALT}").gsub(/=/, '')
    self.update_column(:token, access_token)
    self.token = access_token

    AccessTokenMailer.with(access_token: self, user: self.user).created.deliver_now
  end

  def pending?
    status == Status::PENDING
  end

  def touch_last_access_at!
    self.last_access_at = Time.zone.now
    self.save
  end

  def approve!
    self.status = Status::APPROVED
    self.approved_at = Time.zone.now
    self.save

    AccessTokenMailer.with(access_token: self, user: self.user).activated.deliver_now
  end

  def revoke!
    self.status = Status::REVOKED
    self.revoked_at = Time.zone.now
    self.save
  end
end
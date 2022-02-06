class AccessToken < ApplicationRecord
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
    access_token = Digest::SHA2.hexdigest("#{id}_#{Rails.application.credentials.access_token_salt}").gsub(/=/, '')
    self.update_column(:token, access_token) # usa o update column pra colocar o valor no banco sem callback
    self.token = access_token # usa a setter pra ter o valor pra ser usado no mailer abaixo

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
    self
  end

  def revoke!
    self.status = Status::REVOKED
    self.revoked_at = Time.zone.now
    self.save
  end
end

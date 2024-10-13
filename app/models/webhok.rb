class Webhok < ApplicationRecord

  enum :status, { pending: 0, approved: 1 }
  after_save :notify_subscriber, if: :status_changed?
  belongs_to :user

  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }
  validates :event_type, presence: true

  private

  def status_changed?
    saved_change_to_status?(from: 'pending', to: 'approved')
  end

  def notify_subscriber
    payload = { event_type: event_type, timestamp: Time.now, user_id: user.id, url: url}
    WebhookNotifierJob.perform_later(url, payload)
  end
end

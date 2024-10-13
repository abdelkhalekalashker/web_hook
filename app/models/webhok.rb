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
    # do nothing for now
  end
end

class WebhookNotifierJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3

  sidekiq_retry_in do |count|
    ((count + 1) ** 2) * 60 # seconds
  end

  def perform(webhook_url, payload)
    response = HTTParty.post(webhook_url, body: payload.to_json, headers: { 'Content-Type' => 'application/json' })
    
    unless response.success?
      raise "Failed to send webhook. Response: #{response.body}"
    end
  end
end

class AddStatusToWebhoks < ActiveRecord::Migration[7.0]
  def up
    add_column :webhoks, :status, :integer, default: 0, null: false
    add_column :webhoks, :event_type, :string
  end

  def down
    remove_column :webhoks, :status
    remove_column :webhoks, :event_type
  end
end

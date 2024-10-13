class CreateWebhoks < ActiveRecord::Migration[7.0]
  def change
    create_table :webhoks do |t|
      t.references :user, null: false, foreign_key: true
      t.text :url

      t.timestamps
    end
  end
end

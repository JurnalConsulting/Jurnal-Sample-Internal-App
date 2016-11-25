class CreateTableWebhookRecord < ActiveRecord::Migration
  def change
    create_table :table_webhook_records do |t|
      t.string :topic
      t.string :content
      t.timestamps
    end
  end
end

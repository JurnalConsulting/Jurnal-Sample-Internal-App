class AddColumnWebhookId < ActiveRecord::Migration
  def change
    add_column :table_webhook_records, :webhook_user_id, :string
  end
end

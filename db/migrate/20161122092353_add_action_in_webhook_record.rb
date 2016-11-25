class AddActionInWebhookRecord < ActiveRecord::Migration
  def change
    add_column :table_webhook_records, :action, :string
  end
end

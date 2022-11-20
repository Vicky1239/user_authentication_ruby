class AddCounterForOtpToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :otp_counter, :integer, default: 0
  end
end

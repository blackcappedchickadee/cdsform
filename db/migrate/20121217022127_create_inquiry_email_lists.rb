class CreateInquiryEmailLists < ActiveRecord::Migration
  def change
    create_table :inquiry_email_lists do |t|
      t.string :name
      t.string :email_address

      t.timestamps
    end
  end
end

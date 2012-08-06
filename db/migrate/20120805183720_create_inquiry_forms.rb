class CreateInquiryForms < ActiveRecord::Migration
  def change
    create_table :inquiry_forms do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :performance_dates
      t.string :locations
      t.string :budget
      t.string :event_type
      t.string :additional_comments

      t.timestamps
    end
  end
end

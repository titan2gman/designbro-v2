class AddStationeryFieldsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :back_business_card_details, :string
    add_column :projects, :front_business_card_details, :string

    add_column :projects, :compliment, :string
    add_column :projects, :letter_head, :string
  end
end

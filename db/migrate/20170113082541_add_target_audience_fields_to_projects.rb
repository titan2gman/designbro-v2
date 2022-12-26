class AddTargetAudienceFieldsToProjects < ActiveRecord::Migration[5.0]
  def change
    options = { null: false, default: 5 }

    add_column :projects, :youthful_or_mature, :integer, options
    add_column :projects, :masculine_or_premium, :integer, options
    add_column :projects, :low_income_or_high_income, :integer, options
  end
end

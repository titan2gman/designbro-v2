class RemoveRedundantProjectColumns < ActiveRecord::Migration[5.2]
  def change
    remove_reference :projects, :client, index: true

    remove_column :projects, :bold_or_refined, :integer, default: 5, null: false
    remove_column :projects, :detailed_or_clean, :integer, default: 5, null: false
    remove_column :projects, :handcrafted_or_minimalist, :integer, default: 5, null: false
    remove_column :projects, :low_income_or_high_income, :integer, default: 5, null: false
    remove_column :projects, :masculine_or_premium, :integer, default: 5, null: false
    remove_column :projects, :outmoded_actual, :integer, default: 5, null: false
    remove_column :projects, :serious_or_playful, :integer, default: 5, null: false
    remove_column :projects, :stand_out_or_not_from_the_crowd, :integer, default: 5, null: false
    remove_column :projects, :traditional_or_modern, :integer, default: 5, null: false
    remove_column :projects, :value_or_premium, :integer, default: 5, null: false
    remove_column :projects, :youthful_or_mature, :integer, default: 5, null: false
    remove_column :projects, :target_country_codes, :string, default: [], array: true
    remove_column :projects, :brand_name, :string
    remove_column :projects, :slogan, :string
    remove_column :projects, :additional_text, :text
    remove_column :projects, :company_description, :text
    remove_column :projects, :background_story, :text
    remove_column :projects, :where_it_is_used, :text
    remove_column :projects, :what_is_special, :text
    remove_column :projects, :business_customer, :boolean, default: true, null: false
  end
end

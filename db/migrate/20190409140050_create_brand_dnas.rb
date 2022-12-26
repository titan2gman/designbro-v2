class CreateBrandDnas < ActiveRecord::Migration[5.2]
  def change
    create_table :brand_dnas do |t|
      t.integer :bold_or_refined, default: 5, null: false
      t.integer :detailed_or_clean, default: 5, null: false
      t.integer :handcrafted_or_minimalist, default: 5, null: false
      t.integer :low_income_or_high_income, default: 5, null: false
      t.integer :masculine_or_premium, default: 5, null: false
      t.integer :outmoded_actual, default: 5, null: false
      t.integer :serious_or_playful, default: 5, null: false
      t.integer :stand_out_or_not_from_the_crowd, default: 5, null: false
      t.integer :traditional_or_modern, default: 5, null: false
      t.integer :value_or_premium, default: 5, null: false
      t.integer :youthful_or_mature, default: 5, null: false
      t.string  :target_country_codes, default: [], array: true

      t.references :brand, index: true, foreign_key: true

      t.timestamps
    end

    add_reference :projects, :brand_dna, index: true, foreign_key: true
  end
end

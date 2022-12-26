class AddStyleFieldsToProjects < ActiveRecord::Migration[5.0]
  def change
    options = {null: false, default: 5}

    add_column :projects, :bold_or_refined, :integer, options
    add_column :projects, :outmoded_actual, :integer, options
    add_column :projects, :value_or_premium, :integer, options
    add_column :projects, :detailed_or_clean, :integer, options
    add_column :projects, :serious_or_playful, :integer, options
    add_column :projects, :traditional_or_modern, :integer, options
    add_column :projects, :handcrafted_or_minimalist, :integer, options
    add_column :projects, :stand_out_or_not_from_the_crowd, :integer, options
  end
end

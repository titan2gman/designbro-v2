class AddExperienceAcceptedToDesigners < ActiveRecord::Migration[5.0]
  def change
    add_column :designers, :logo_accepted, :boolean, null: false, default: false
    add_column :designers, :brand_identity_accepted, :boolean, null: false, default: false
    add_column :designers, :packaging_accepted, :boolean, null: false, default: false
  end
end

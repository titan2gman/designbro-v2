class CreateDesignerExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :designer_experiences do |t|
      t.references :designer, index: true, foreign_key: true
      t.references :product_category, index: true, foreign_key: true
      t.integer    :experience
      t.string     :state, null: false, default: 'draft'

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          INSERT INTO designer_experiences (designer_id, product_category_id, experience, state, created_at, updated_at)
          SELECT designers.id, product_categories.id, designers.experience_brand, designers.brand_identity_state, designers.created_at, designers.updated_at
          FROM designers, product_categories
          WHERE product_categories.name = 'Brand Identity';
        SQL

        execute <<-SQL
          INSERT INTO designer_experiences (designer_id, product_category_id, experience, state, created_at, updated_at)
          SELECT designers.id, product_categories.id, designers.experience_packaging, designers.packaging_state, designers.created_at, designers.updated_at
          FROM designers, product_categories
          WHERE product_categories.name = 'Packaging';
        SQL
      end

      dir.down do
      end
    end

    remove_column :designers, :experience_brand, :integer
    remove_column :designers, :experience_packaging, :integer
    remove_column :designers, :brand_identity_state, :string, null: false, default: 'draft'
    remove_column :designers, :packaging_state, :string, null: false, default: 'draft'
  end
end

class AddStatesToDesigner < ActiveRecord::Migration[5.1]
  def change
    add_column :designers, :brand_identity_state, :string, null: false, default: 'draft'
    add_column :designers, :packaging_state, :string, null: false, default: 'draft'
    add_index :designers, :brand_identity_state
    add_index :designers, :packaging_state

    Designer.all.each do |designer|
      designer.update(
        brand_identity_state: Designer::STATE_BRAND_IDENTITY_PENDING,
        packaging_state: Designer::STATE_PACKAGING_PENDING
      ) if designer.portfolio_works.any?

      designer.update(
        brand_identity_state: Designer::STATE_BRAND_IDENTITY_APPROVED
      ) if designer.brand_identity_accepted

      designer.update(
        packaging_state: Designer::STATE_PACKAGING_APPROVED
      ) if designer.packaging_accepted
    end

    remove_column :designers, :logo_accepted
    remove_column :designers, :brand_identity_accepted
    remove_column :designers, :packaging_accepted
  end
end

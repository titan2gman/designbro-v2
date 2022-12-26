class AddDesignerDiscountCoulumnToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :designer_discount_amount_cents, :integer, default: 0, null: false

    execute <<-SQL
      UPDATE projects SET designer_discount_amount_cents = discount_amount_cents
    SQL
  end
end

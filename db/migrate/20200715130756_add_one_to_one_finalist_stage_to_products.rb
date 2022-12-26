class AddOneToOneFinalistStageToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :one_to_one_finalist_stage_expire_days, :integer, null: false, default: 10
    rename_column :products, :finalist_stage_expire_days, :contest_finalist_stage_expire_days

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE products
          SET one_to_one_finalist_stage_expire_days = contest_finalist_stage_expire_days
        SQL
      end

      dir.down do
      end
    end
  end
end

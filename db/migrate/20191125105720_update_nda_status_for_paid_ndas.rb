class UpdateNdaStatusForPaidNdas < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :ndas, null: true

    reversible do |dir|
      dir.up do
        Brand.joins(brand_dnas: :projects).where(projects: { state: Project::DESIGNER_CAN_READ_STATES }).find_each do |brand|
          if (brand.active_nda&.nda_type == 'free')
            brand.active_nda.update(is_paid: true)
          end
        end
      end
    end
  end
end

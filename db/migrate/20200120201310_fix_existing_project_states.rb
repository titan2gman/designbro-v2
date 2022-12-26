class FixExistingProjectStates < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      UPDATE projects
      SET state = 'draft'
      WHERE projects.state IN ('waiting_for_style_details', 'waiting_for_audience_details', 'waiting_for_finish_details', 'waiting_for_details', 'waiting_for_checkout', 'waiting_for_payment', 'waiting_for_stationery_details', 'waiting_for_payment_and_stationery_details');
    SQL

    # Project.draft.find_each do |project|
    #   project.update(current_step: project.product.project_builder_steps.first)
    # end
  end

  def down
  end
end



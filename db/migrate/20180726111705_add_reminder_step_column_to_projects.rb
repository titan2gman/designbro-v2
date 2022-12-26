class AddReminderStepColumnToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :abandoned_cart_reminder_step, :string

    Project.where(abandoned_cart_reminder_step: nil)
           .update_all(abandoned_cart_reminder_step: Project::STATE_FIRST_REMINDER.to_s)
  end
end

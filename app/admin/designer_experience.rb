# frozen_string_literal: true

ActiveAdmin.register DesignerExperience do
  menu parent: 'User'

  member_action :approve, method: :put
  member_action :disapprove, method: :put

  permit_params :designer_id, :product_category_id, :experience, :state

  controller do
    before_action :approve_user, only: [:approve]

    def approve
      resource.approve!
      ApprovePortfolioJob.set(wait: 5.minutes).perform_later(resource.designer_id, resource.designer.count_of_approved_states)
      redirect_to resource_path, notice: 'Approved!'
    end

    def disapprove
      DesignerPortfolioDisapprover.call(resource)
      redirect_to resource_path, notice: 'Disapproved!'
    end

    private

    def approve_user
      resource.designer.user.approve! if resource.designer.user.disabled?
    end
  end

  csv do
    column :id
    column :designer_id
    column :product_category_id
    column :experience
    column :state
    column :created_at
    column :updated_at
  end
end

# frozen_string_literal: true

class DesignerPortfolioDisapprover
  include Callable

  def initialize(experience)
    @experience = experience
    @designer = experience.designer
    @product_category = experience.product_category
  end

  def call
    @experience.disapprove!

    @designer.spots.joins(:project)
             .merge(Spot.can_be_deleted_by_admin)
             .merge(Project.joins(:product).where(products: { product_category: @product_category }))
             .update_all(state: Spot::STATE_DELETED_BY_ADMIN)

    DisapprovePortfolioJob.set(wait: 5.minutes).perform_later(
      @designer.id, @designer.count_of_disapproved_states
    )
  end
end

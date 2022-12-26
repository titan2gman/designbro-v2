# frozen_string_literal: true

class SearchedProjectsQuery
  def initialize(projects:, search_params: {}, sort_params: [], spots_state: nil)
    @projects = projects.includes(
      :discount, :payments, :colors,
      :competitors, :inspirations, :existing_designs,
      :additional_documents, {
        spots: :design
      }, {
        product: [:product_category, :additional_design_prices]
      },
      brand_dna: [:competitors, { brand: [:company, :ndas] }]
    )

    search_by_spots_state(spots_state) if spots_state

    @search_params = search_params
    @sort_params = sort_params
  end

  def search
    search_by_product_category if @search_params[:product_category_id]

    search = @projects.ransack(@search_params)
    search.sorts = @sort_params
    @projects = search.result
  end

  private

  def search_by_spots_state(spots_state)
    @projects = @projects.spots_free if spots_state == 'free'
    @projects = @projects.spots_taken if spots_state == 'taken'
  end

  def search_by_product_category
    @projects = @projects.joins(:product).where(
      products: { product_category_id: @search_params[:product_category_id] }
    ).or(@projects.joins(:product).where(manual_product_category_id: @search_params[:product_category_id]))
  end
end

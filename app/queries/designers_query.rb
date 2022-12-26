# frozen_string_literal: true

module DesignersQuery
  class Search
    attr_accessor :initial_relation

    def initialize(initial_relation = Designer.all)
      @initial_relation = initial_relation
    end

    def search(params)
      relation = prepare_query(initial_relation)
      relation = filter(relation, params)
      relation = order(relation, params)

      relation
    end

    def prepare_query(relation)
      relation.includes(
        :avatar,
        :uploaded_hero_image,
        approved_designer_experiences: :product_category,
        hero_image: :uploaded_featured_image
      ).where(visible: true, one_to_one_available: true)
    end

    def filter(relation, params)
      relation unless params[:search]

      relation.where('designers.display_name ILIKE :search OR designers.description ILIKE :search', { search: "%#{params[:search]}%" })
    end

    def order(relation, params)
      if params[:filter] == 'featured'
        relation = relation.where.not(badge: nil).where.not(badge: '')
      elsif ['average_rating', 'reviews_count'].include?(params[:filter])
        relation = relation.order("designers.#{params[:filter]} DESC")
      elsif ['last_seen_at'].include?(params[:filter])
        relation = relation.joins(:user).order("users.#{params[:filter]} DESC NULLS LAST")
      elsif ['average_response_time'].include?(params[:filter])
        relation = relation.order("designers.#{params[:filter]} ASC")
      end

      relation.order('designers.created_at DESC NULLS LAST').order('designers.id DESC')
    end
  end
end

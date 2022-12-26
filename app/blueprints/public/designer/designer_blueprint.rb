# frozen_string_literal: true

class Public::Designer::DesignerBlueprint < Blueprinter::Base
  identifier :id

  fields :display_name,
         :visible,
         :one_to_one_allowed,
         :description,
         :badge,
         :average_response_time,
         :average_rating,
         :reviews_count,
         :last_seen_at,
         :created_at

  field :country do |designer|
    ISO3166::Country.new(designer.country_code)&.name
  end

  field :avatar do |designer|
    designer.avatar&.file&.url || URI.join(Rails.application.routes.url_helpers.root_url, ActionController::Base.helpers.asset_path('avatar.jpg'))
  end

  field :hero_image do |designer|
    designer.uploaded_hero_image&.file&.url || designer.hero_image&.uploaded_featured_image&.file&.url
  end

  field :languages do |designer|
    designer.languages.map { |l| ::LANGUAGES_HASH[l] }
  end

  association :approved_designer_experiences, blueprint: Public::Designer::ApprovedExperienceBlueprint

  view :single do
    association :portfolio, blueprint: Public::Designer::PortfolioBlueprint do |designer, _options|
      designer.portfolio_works.order(id: :desc)
    end

    association :designs, blueprint: Public::Designer::DesignBlueprint do |designer, _options|
      designer
        .winner_spots
        .joins(project: :active_nda)
        .where(ndas: { nda_type: Nda.nda_types[:free] })
        .where.not(projects: { state: 'refunded' })
        .order(created_at: :desc)
    end

    association :reviews, blueprint: Public::Designer::ReviewBlueprint do |designer, _options|
      designer.reviews.order(id: :desc)
    end
  end

  view :list do
  end
end

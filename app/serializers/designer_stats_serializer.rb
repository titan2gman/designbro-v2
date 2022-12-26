# frozen_string_literal: true

class DesignerStatsSerializer < ActiveModel::Serializer
  attributes :available_for_payout,
             # :logo_in_progress_count,
             # :brand_identity_in_progress_count,
             # :packaging_in_progress_count,
             :in_progress_count,
             :finalists_count,
             :winners_count,
             :expired_spots_percentage
end

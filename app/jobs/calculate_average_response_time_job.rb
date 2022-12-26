# frozen_string_literal: true

class CalculateAverageResponseTimeJob < ApplicationJob
  def perform
    Designer.joins(:direct_conversation_messages).uniq.each do |designer|
      seconds = designer.direct_conversation_messages.select('CASE WHEN seconds_since_last_message > 86400 THEN 86400 ELSE seconds_since_last_message END as value').map(&:value).compact

      designer.update_columns(
        average_response_time: seconds.count > 0 ? seconds.sum / seconds.count.to_f : nil
      )
    end
  end
end

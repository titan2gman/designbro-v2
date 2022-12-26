# frozen_string_literal: true

module ProjectExpireMethods
  extend ActiveSupport::Concern

  include TimeMethods

  # expired

  {
    design_stage_expired?: { stage: :design_stage },
    finalist_stage_expired?: { stage: :finalist_stage },
    files_stage_expired?: { stage: :files_stage },
    review_files_expired?: { stage: :review_files_stage }
  }.each do |method, attrs|
    define_method(method) do
      expired?(attrs[:stage])
    end
  end

  # warnings

  {
    send_three_days_of_design_stage_left_warning?: { stage: :design_stage, time_left: 3.days },
    send_one_day_of_design_stage_left_warning?: { stage: :design_stage, time_left: 1.days },
    send_two_days_of_finalist_stage_left_warning?: { stage: :finalist_stage, time_left: 2.days },
    send_one_day_of_finalist_stage_left_warning?: { stage: :finalist_stage, time_left: 1.day },
    send_two_days_of_files_stage_left_warning?: { stage: :files_stage, time_left: 2.days },
    send_one_day_of_files_stage_left_warning?: { stage: :files_stage, time_left: 1.day },
    send_three_days_of_review_files_stage_left_warning?: { stage: :review_files_stage, time_left: 3.days }
  }.each do |method, attrs|
    define_method(method) do
      send_left_warning?(attrs[:stage], attrs[:time_left])
    end
  end

  # expire times

  def design_stage_expire_duration
    contest? ? contest_design_stage_expire_days.days : one_to_one_design_stage_expire_days.days
  end

  def finalist_stage_expire_duration
    contest? ? contest_finalist_stage_expire_days.days : one_to_one_finalist_stage_expire_days.days
  end

  def files_stage_expire_duration
    files_stage_expire_days.days
  end

  def review_files_stage_expire_duration
    review_files_stage_expire_days.days
  end

  private

  def expired?(stage)
    public_send("#{stage}_expires_at") <= Time.current
  end

  def send_left_warning?(stage, time)
    ((public_send("#{stage}_expires_at") - Time.current) / 1.hour).round == time / 1.hour
  end
end

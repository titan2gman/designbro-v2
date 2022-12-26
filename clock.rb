# frozen_string_literal: true

require_relative './config/boot'
require_relative './config/environment'

require 'clockwork'
include Clockwork

every(60.minutes, 'CheckSpotsJob') do
  CheckSpotsJob.perform_later
end

every(AbandonedCarts::RemindersSender::REMINDERS_GAP.minutes, 'SendAbandonedCartRemindersJob') do
  SendAbandonedCartRemindersJob.perform_later
end

every(Projects::NotifySourceFilesUploaded::NOTIFY_PERIOD.minutes, 'NotifySourceFilesUploadedJob') do
  NotifySourceFilesUploadedJob.perform_later
end

every(60.minutes, 'CheckProjectsJob') do
  CheckProjectsJob.perform_later
end

every(1.day, 'RemoveEmptyBrands', at: '02:00') do
  RemoveEmptyBrandsJob.perform_later
end

every(1.day, 'CalculateAverageResponseTime', at: '02:30') do
  CalculateAverageResponseTimeJob.perform_later
end

every(1.day, 'CalculateAverageRating', at: '03:00') do
  CalculateAverageRatingJob.perform_later
end

every(1.day, 'SetDesignerHeroImage', at: '03:30') do
  SetDesignerHeroImageJob.perform_later
end

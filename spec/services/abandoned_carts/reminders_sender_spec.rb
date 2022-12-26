# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AbandonedCarts::RemindersSender do
  subject { described_class.new }

  let(:payment) { create(:payment) }
  let(:brand) { create(:brand, name: '') }
  let(:brand_dna) { create(:brand_dna, brand: brand) }
  let(:time_now) { Time.current.change(usec: 0) }
  let(:fifty_minutes_before) { time_now - 15.minutes }
  let(:thirty_minutes_before) { time_now - 30.minutes }
  let(:one_hour_before) { time_now - 1.hour }
  let(:two_hours_before) { time_now - 2.hours }
  let(:abandoned_cart_reminder_1) { create(:abandoned_cart_reminder, step: 1, name: 'first_reminder', minutes_to_reminder: 15) }
  let(:abandoned_cart_reminder_2) { create(:abandoned_cart_reminder, step: 2, name: 'second_reminder', minutes_to_reminder: 30) }
  let(:abandoned_cart_reminder_3) { create(:abandoned_cart_reminder, step: 3, name: 'third_reminder', minutes_to_reminder: 60) }
  let(:project_1) { create(:project, state: :waiting_for_checkout, updated_at: fifty_minutes_before) }
  let(:project_2) { create(:project, state: :waiting_for_details, updated_at: thirty_minutes_before, abandoned_cart_reminder_step: 'second_reminder') }
  let(:project_3) { create(:project, state: :draft, updated_at: one_hour_before, abandoned_cart_reminder_step: 'third_reminder') }
  let(:project_4) { create(:project, state: :waiting_for_style_details, updated_at: fifty_minutes_before, abandoned_cart_reminder_step: 'reminding_completed') }
  let(:project_5) { create(:project, state: :waiting_for_finish_details, updated_at: two_hours_before) }
  let(:project_6) { create(:project, state: :waiting_for_audience_details, updated_at: two_hours_before, abandoned_cart_reminder_step: 'first_reminder') } # time not_match first_reminder
  let(:project_7) { create(:project, state: :design_stage, updated_at: fifty_minutes_before) } # not before_payment state
  let(:project_8) { create(:project, state: :draft, updated_at: fifty_minutes_before, brand_dna: brand_dna) } # brand.name must be ''
  let(:project_9) { create(:project, state: :draft, updated_at: fifty_minutes_before) } # client.opt_out true
  let(:project_10) { create(:project, state: :waiting_for_checkout, payment: payment, updated_at: fifty_minutes_before) }
  let(:reminders_gap) { AbandonedCarts::RemindersSender::REMINDERS_GAP }

  describe '#call' do
    before do
      project_1
      project_2
      project_3
    end

    let(:projects) { Project.all }

    it 'send mails to correct projects' do
      allow_any_instance_of(Projects::AbandonedCartReminders::Send).to receive(:call) { true }
      expect(subject).to receive(:projects) { projects }

      subject.call

      expect(project_1.reload.second_reminder?).to be_truthy
      expect(project_2.reload.third_reminder?).to be_truthy
      expect(project_3.reload.reminding_completed?).to be_truthy
    end
  end

  describe '#projects' do
    before do
      project_1
      project_2
      project_3
      project_4
      project_5
      project_6
      project_7
      project_8
      project_9
      abandoned_cart_reminder_1
      abandoned_cart_reminder_2
      abandoned_cart_reminder_3
      project_9.brand.company.clients.first.update_column(:opt_out, true)
      project_10
    end

    it 'not returns project_1,2,3' do
      result = subject.send(:projects)
      expect(result.count).to eq 3
      expect(result.pluck(:id).sort).to match([project_1.id, project_2.id, project_3.id])
    end
  end

  describe '#reminders' do
    before do
      abandoned_cart_reminder_1
      abandoned_cart_reminder_2
      abandoned_cart_reminder_3
    end

    let(:expected_result) do
      [
        {
          start: abandoned_cart_reminder_1.minutes_to_reminder.to_s,
          end: (abandoned_cart_reminder_1.minutes_to_reminder + reminders_gap).to_s,
          step: abandoned_cart_reminder_1.name
        },
        {
          start: abandoned_cart_reminder_2.minutes_to_reminder.to_s,
          end: (abandoned_cart_reminder_2.minutes_to_reminder + reminders_gap).to_s,
          step: abandoned_cart_reminder_2.name
        },
        {
          start: abandoned_cart_reminder_3.minutes_to_reminder.to_s,
          end: (abandoned_cart_reminder_3.minutes_to_reminder + reminders_gap).to_s,
          step: abandoned_cart_reminder_3.name
        }
      ]
    end

    it 'returns reminders attributes' do
      result = subject.send(:reminders)
      expect(result).to match(expected_result)
    end
  end

  describe '#reminder_time_ranges_condition' do
    before do
      abandoned_cart_reminder_1
      abandoned_cart_reminder_2
    end

    let(:expected_result) do
      <<-SQL
        ( (EXTRACT(EPOCH FROM now() - projects.updated_at::timestamp)::int/60
            BETWEEN #{abandoned_cart_reminder_1.minutes_to_reminder} AND #{abandoned_cart_reminder_1.minutes_to_reminder + reminders_gap} )
            AND projects.abandoned_cart_reminder_step = 'first_reminder' )
          OR ( (EXTRACT(EPOCH FROM now() - projects.updated_at::timestamp)::int/60
            BETWEEN #{abandoned_cart_reminder_2.minutes_to_reminder} AND #{abandoned_cart_reminder_2.minutes_to_reminder + reminders_gap} )
            AND projects.abandoned_cart_reminder_step = 'second_reminder' )
      SQL
        .gsub(/\s+/, ' ').strip
    end

    it 'returns sql query condition for reminder time ranges' do
      result = subject.send(:reminder_time_ranges_condition)
      expect(result).to eq expected_result
    end
  end
end

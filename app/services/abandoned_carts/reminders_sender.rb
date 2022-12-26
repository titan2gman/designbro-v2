# frozen_string_literal: true

module AbandonedCarts
  class RemindersSender
    REMINDERS_GAP = 15

    def call
      projects.each(&:send_next_reminder!)
    end

    private

    def projects
      @projects ||= Project.joins(brand_dna: { brand: { company: :clients } })
                           .where(companies: { id: companies_without_payments })
                           .before_payment
                           .where(clients: { opt_out: false })
                           .where.not(projects: {
                                        abandoned_cart_reminder_step: 'reminding_completed'
                                      }, brands: {
                                        name: [nil, '']
                                      })
                           .where(reminder_time_ranges_condition).uniq
    end

    def reminders
      AbandonedCartReminder.all.map do |reminder|
        {
          start: reminder.minutes_to_reminder.to_s,
          end: (reminder.minutes_to_reminder + REMINDERS_GAP).to_s,
          step: reminder.name
        }
      end
    end

    def companies_without_payments
      Company.left_joins(projects: :payments).group('companies.id').having('count(payments.id) = 0').uniq.pluck(:id)
    end

    def reminder_time_ranges_condition
      reminders.map do |reminder|
        <<-SQL
          ( (EXTRACT(EPOCH FROM now() - projects.updated_at::timestamp)::int/60
              BETWEEN
                #{Arel.sql(reminder[:start])}
              AND
                #{Arel.sql(reminder[:end])}
            )
            AND
            projects.abandoned_cart_reminder_step = '#{Arel.sql(reminder[:step])}'
          )
        SQL
          .gsub(/\s+/, ' ').strip
      end.join(' OR ')
    end
  end
end

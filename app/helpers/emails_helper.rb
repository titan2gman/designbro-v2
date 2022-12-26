# frozen_string_literal: true

module EmailsHelper
  DEFAULT_PROJECT_TITLE_LENGTH = 24

  def letterify_name(name)
    name.split(/ /).map { |w| w[0, 1] }.join.upcase
  end

  def user_link(user)
    if user.client?
      'c'
    elsif user.designer?
      'd'
    end
  end

  def host_url
    Rails.application.config.action_mailer.default_url_options[:host]
  end

  def user_role(user)
    if user.client?
      'client'
    elsif user.designer?
      'designer'
    end.upcase
  end

  def project_type_name(project)
    project.product.name
  end

  def mail_from
    Rails.application.config.action_mailer.default_options[:from]
  end

  def cut_on_word(str, length = DEFAULT_PROJECT_TITLE_LENGTH)
    str.truncate((length + 3), separator: ' ')
  end

  def humanize_expire_duration(duration)
    distance_of_time_in_words(Time.zone.now, Time.zone.now + duration)
  end

  def format_price(price)
    format('%g', ('%.2f' % price))
  end
end

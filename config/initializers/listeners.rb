# frozen_string_literal: true

Rails.application.config.to_prepare do
  Wisper.clear

  Wisper.subscribe(ProjectListener.new, scope: Project)
  Wisper.subscribe(ProjectListener.new, scope: ProjectsExpire)

  Wisper.subscribe(SpotListener.new, scope: Spot)
  Wisper.subscribe(ProjectSourceFileListener.new, scope: ProjectSourceFile)

  Wisper.subscribe(PayoutListener.new, scope: Payout)
end

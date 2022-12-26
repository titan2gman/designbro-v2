# frozen_string_literal: true

module EarningCreator
  class PayFinalists
    include Callable

    def initialize(project)
      @project   = project
      @winner    = project.winner
      @finalists = project.spots.finalist_states
    end

    def call
      raise 'No winner in project!' unless @winner

      @finalists.each do |finalist|
        Earning.create!(
          project: @project,
          designer: finalist.designer,
          amount: @project.finalist_prize_in_cents
        )
      end
    end
  end

  class PayWinner
    include Callable

    def initialize(project)
      @project = project
    end

    def call
      Earning.create!(
        project: @project,
        designer: @project.winner,
        amount: @project.winner_prize_in_cents
      )
    end
  end
end

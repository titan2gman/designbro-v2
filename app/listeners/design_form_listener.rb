# frozen_string_literal: true

class DesignFormListener
  def new_design_uploaded(design)
    ClientMailer.new_design_uploaded(design: design).deliver_later
  end
end

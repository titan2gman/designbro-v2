# frozen_string_literal: true

class DesignFinalistMaker
  include Wisper::Publisher

  def call(design)
    broadcast(:finalist_selected, design) if design.make_finalist!
    design
  end
end

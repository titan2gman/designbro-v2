# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Designer', :js do
  scenario 'can view accepted NDAs' do
    designer = create(:designer)

    another_designer_ndas      = create_list(:designer_nda, 2)
    not_allowed_projects_names = another_designer_ndas.map(&:project).map(&:name)

    current_designer_ndas  = create_list(:designer_nda, 2, designer: designer)
    allowed_projects_names = current_designer_ndas.map(&:project).map(&:name)

    login_as(designer.user)
    visit '/d/ndas'

    allowed_projects_names.each do |name|
      expect(page).to have_content(name)
    end

    not_allowed_projects_names.each do |name|
      expect(page).not_to have_content(name)
    end
  end
end

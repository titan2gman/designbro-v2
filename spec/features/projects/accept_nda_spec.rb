# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Project NDA can be accepted', js: true do
  describe 'by Designer' do
    [:custom, :standard].each do |nda_type|
      describe "type of NDA: #{nda_type}" do
        scenario 'accepted' do
          project = create(:project_without_nda, state: Project::STATE_DESIGN_STAGE)
          create(:"#{nda_type}_nda", project: project)
          designer = create(:designer)

          DesignerNda.create(
            designer: designer,
            nda: project.nda
          )

          login_as(designer.user)
          visit '/d/discover'

          find('a.main-button').click
          expect(page).to have_selector('.spinner')

          expect(page).to have_content(project.name)
          expect(page).not_to have_content('Non-Disclosure Agreement')
        end

        scenario 'not accepted' do
          project = create(:project_without_nda, state: Project::STATE_DESIGN_STAGE)
          create(:"#{nda_type}_nda", project: project)
          user = create(:designer).user

          login_as(user)
          visit '/d/discover'

          find('a.main-button').click
          expect(page).to have_content('Non-Disclosure Agreement')

          click_button('I Agree')
          expect(page).to have_selector('.spinner')
          expect(page).to have_content(project.name)
        end
      end
    end

    scenario 'type of NDA: free' do
      project = create(:project_without_nda, state: Project::STATE_DESIGN_STAGE)
      create(:free_nda, project: project)
      user = create(:designer).user

      login_as(user)
      visit '/d/discover'

      find('a.main-button').click
      expect(page).to have_selector('.spinner')

      expect(page).to have_content(project.name)
      expect(page).not_to have_content('Non-Disclosure Agreement')
    end
  end
end

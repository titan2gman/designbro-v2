# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'project money methods' do
  describe '#winner_prize' do
    context 'is finalists' do
      it 'returns 95% of total prize' do
        project  = create(:project)
        designer = create(:designer)

        create(:finalist_design, project: project, designer: designer)

        allow(project).to receive(:total_prize).and_return(937)

        expect(project.winner_prize).to eq(890)
      end
    end

    context 'is not finalists' do
      it 'returns 100% of total prize' do
        project = create(:project)
        allow(project).to receive(:total_prize).and_return(937)

        expect(project.winner_prize).to eq(937)
      end
    end

    context 'in cents' do
      it 'returns 10000% of winner prize' do
        project = create(:project)
        allow(project).to receive(:winner_prize).and_return(937)

        expect(project.winner_prize_in_cents).to eq(93_700)
      end
    end
  end

  describe '#finalist_prize' do
    context 'with 1 finalist' do
      it 'returns 5% of total prize' do
        project  = create(:project)
        designer = create(:designer)

        create(:finalist_design, project: project, designer: designer)

        allow(project).to receive(:total_prize).and_return(937)

        expect(project.finalist_prize).to eq(46)
      end
    end

    context 'with 2 finalist' do
      it 'returns 2.5% of total prize' do
        designer = create(:designer)
        project  = create(:brand_identity_project)

        create(:finalist_design, project: project, designer: designer)
        create(:stationery_design, project: project, designer: designer)

        allow(project).to receive(:total_prize).and_return(937)

        expect(project.finalist_prize).to eq(23)
      end
    end

    context 'with no finalists' do
      it 'returns 0' do
        project = create(:project)

        expect(project.finalist_prize).to eq(0)
      end
    end

    context 'in cents' do
      it 'returns 10000% of finalist prize' do
        project  = create(:project)
        designer = create(:designer)
        project.designers << designer

        create(:finalist_design, project: project, designer: designer)

        allow(project).to receive(:finalist_prize).and_return(37)

        expect(project.finalist_prize_in_cents).to eq(3700)
      end
    end
  end

  describe '#total_prize' do
    it 'returns 75% of project type price' do
      designer_discount_amount = 30.0
      project = create(:project_without_nda, type_price: 1101, designer_discount_amount: designer_discount_amount)
      create(:standard_nda, project: project)
      expected_result = (project.type_price - designer_discount_amount) * 0.75

      expect(project.total_prize).to eq(expected_result.to_i)
    end
  end
end

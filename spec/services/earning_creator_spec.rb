# frozen_string_literal: true

RSpec.describe EarningCreator do
  describe EarningCreator::PayFinalists do
    it 'creates earning for each finalist' do
      project   = create(:project)
      designer1 = create(:designer)
      designer2 = create(:designer)

      create(:winner_design,   project: project)
      create(:finalist_design, project: project, designer: designer1)
      create(:finalist_design, project: project, designer: designer2)

      EarningCreator::PayFinalists.call(project)

      [designer1, designer2].each do |designer|
        expect(designer.earnings.count).to eq(1)

        expect(designer.earnings.first.amount)
          .to eq(project.finalist_prize_in_cents.to_i)
      end
    end

    it "creates earning for each finalist's design" do
      project  = create(:project)
      designer = create(:designer)

      create(:winner_design,   project: project)
      create(:finalist_design, project: project, designer: designer)
      create(:finalist_design, project: project, designer: designer)

      EarningCreator::PayFinalists.call(project)

      expect(designer.earnings.count).to eq(2)
      expect(designer.earnings.last.amount).to eq(project.finalist_prize_in_cents.to_i)
      expect(designer.earnings.first.amount).to eq(project.finalist_prize_in_cents.to_i)
    end

    it 'raises exception if there is no winner in project' do
      project = create(:project)

      create_list(:finalist_design, 3, project: project)

      expect { EarningCreator::PayFinalists.call(project) }
        .to raise_exception('No winner in project!')
    end
  end

  describe EarningCreator::PayWinner do
    it 'creates earning for winner' do
      project  = create(:project)
      designer = create(:designer)

      create(:winner_design, project: project, designer: designer)

      EarningCreator::PayWinner.call(project)

      expect(designer.earnings.count).to eq(1)

      expect(designer.earnings.first.amount)
        .to eq(project.winner_prize_in_cents)
    end
  end
end

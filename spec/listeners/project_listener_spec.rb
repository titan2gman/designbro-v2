# frozen_string_literal: true

RSpec.describe ProjectListener do
  subject { ProjectListener.new }
  let(:project) { create(:project) }

  describe '#payment_received' do
    it 'delivers payment_received to ClientMailer' do
      expect(ClientMailer).to receive(:payment_received).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.payment_received(project)
    end
  end

  describe '#bank_transfer_payment_received' do
    it 'delivers bank_transfer_payment_received to ClientMailer' do
      expect(ClientMailer).to receive(:bank_transfer_payment_received).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.bank_transfer_payment_received(project)
    end
  end

  describe '#finalist_stage_started' do
    context 'not brand identity' do
      let(:project) { create(:project, project_type: [:logo, :packaging].sample) }

      it 'delivers:
       finalist_stage_started to ClientMailer
       selected_as_finalist to DesignerMailer for each finalist
       design_eliminated to DesignerMailer for each designer with uploaded design' do
        design = create(:finalist_design, project: project)
        user = design.designer.user
        designer = create(:designer)
        uploaded_design = create(:design, project: project, designer: designer)

        expect(ClientMailer).to receive(:finalist_stage_started).with(project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )
        expect(DesignerMailer).to receive(:selected_as_finalist).with(user: user, project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )
        expect(DesignerMailer).to receive(:design_eliminated).with(design: uploaded_design).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )

        subject.finalist_stage_started(project)
      end
    end

    context 'brand_identity' do
      let(:project) { create(:brand_identity_project) }

      it 'delivers:
       finalist_stage_started to ClientMailer
       selected_as_finalist_for_brand_identity to DesignerMailer for each finalist
       design_eliminated to DesignerMailer for each designer with uploaded design' do
        design = create(:finalist_design, project: project)
        user = design.designer.user
        designer = create(:designer)
        uploaded_design = create(:design, project: project, designer: designer)

        expect(ClientMailer).to receive(:brand_identity_finalist_stage_started).with(project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )
        expect(DesignerMailer).to receive(:selected_as_finalist_for_brand_identity).with(user: user, project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )
        expect(DesignerMailer).to receive(:design_eliminated).with(design: uploaded_design).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )

        subject.finalist_stage_started(project)
      end
    end
  end

  describe '#files_stage_started' do
    it 'delivers selected_as_winner to DesignerMailer' do
      expect(DesignerMailer).to receive(:selected_as_winner).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.files_stage_started(project)
    end
  end

  describe '#review_files_stage_started' do
    it 'delivers review_files_stage_started to ClientMailer' do
      expect(ClientMailer).to receive(:review_files_stage_started).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.review_files_stage_started(project)
    end
  end

  describe '#contest_completed' do
    it 'delivers contest_completed to DesignerMailer' do
      create(:winner_design, project: project)

      expect(DesignerMailer).to receive(:contest_completed).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.contest_completed(project)
    end
  end

  describe '#file_auto_approve' do
    it 'delivers file_auto_approve to DesignerMailer' do
      create(:winner_design, project: project)

      expect(ClientMailer).to receive(:file_auto_approve).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.file_auto_approve(project)
    end
  end

  describe '#expire_project' do
    context 'with project in design_stage' do
      let(:project) { create(:project, state: Project::STATE_DESIGN_STAGE) }

      it 'delivers:
       design_stage_time_out to DesignerMailer for all designers
       design_stage_time_out to SupportMailer' do
        designer = create(:designer)
        create_list(:design, 2, project: project, designer: designer)
        create_list(:design, 2)

        expect(DesignerMailer).to receive(:design_stage_time_out).with(user: designer.user, project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )
        expect(SupportMailer).to receive(:design_stage_time_out).with(project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )

        subject.expire_project(project)
      end

      context 'without designers' do
        it 'delivers:
         design_stage_time_out to SupportMailer
         design_stage_time_out to ClientMailer' do
          expect(ClientMailer).to receive(:design_stage_time_out).with(project: project).and_return(
            double('email').tap { |email| expect(email).to receive(:deliver_later) }
          )
          expect(SupportMailer).to receive(:design_stage_time_out).with(project: project).and_return(
            double('email').tap { |email| expect(email).to receive(:deliver_later) }
          )

          subject.expire_project(project)
        end
      end
    end

    context 'with project in finalist_stage' do
      let(:project) { create(:project, state: Project::STATE_FINALIST_STAGE) }

      it 'delivers:
       finalist_stage_time_out to ClientMailer
       finalist_stage_time_out to DesignerMailer for all finalists
       finalist_stage_time_out to SupportMailer' do
        designer = create(:designer)
        create(:finalist_design, project: project, designer: designer)
        create_list(:design, 2, project: project)

        expect(ClientMailer).to receive(:finalist_stage_time_out).with(project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )
        expect(DesignerMailer).to receive(:finalist_stage_time_out).with(user: designer.user, project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )
        expect(SupportMailer).to receive(:finalist_stage_time_out).with(project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )

        subject.expire_project(project)
      end
    end

    context 'with project in files_stage' do
      let(:project) { create(:project, state: Project::STATE_FILES_STAGE) }

      it 'delivers:
       files_stage_time_out to ClientMailer
       files_stage_time_out to DesignerMailer for winner
       files_stage_time_out to SupportMailer' do
        create(:winner_design, project: project)
        create_list(:design, 2, project: project)

        expect(ClientMailer).to receive(:files_stage_time_out).with(project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )
        expect(DesignerMailer).to receive(:files_stage_time_out).with(project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )
        expect(SupportMailer).to receive(:files_stage_time_out).with(project: project).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )

        subject.expire_project(project)
      end
    end
  end

  describe '#design_stage_three_days_left' do
    it 'delivers design_stage_three_days_left to ClientMailer' do
      expect(ClientMailer).to receive(:design_stage_three_days_left).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.design_stage_three_days_left(project)
    end
  end

  describe '#design_stage_one_day_left' do
    it 'delivers design_stage_one_day_left to ClientMailer' do
      expect(ClientMailer).to receive(:design_stage_one_day_left).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.design_stage_one_day_left(project)
    end
  end

  describe '#finalist_stage_two_days_left' do
    it 'delivers finalist_stage_two_days_left to ClientMailer' do
      expect(ClientMailer).to receive(:finalist_stage_two_days_left).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.finalist_stage_two_days_left(project)
    end
  end

  describe '#finalist_stage_one_day_left' do
    it 'delivers finalist_stage_one_day_left to ClientMailer' do
      expect(ClientMailer).to receive(:finalist_stage_one_day_left).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.finalist_stage_one_day_left(project)
    end
  end

  describe '#files_stage_two_days_left' do
    it 'delivers files_stage_two_days_left to DesignerMailer' do
      expect(DesignerMailer).to receive(:files_stage_two_days_left).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.files_stage_two_days_left(project)
    end
  end

  describe '#files_stage_one_day_left' do
    it 'delivers files_stage_one_day_left to DesignerMailer' do
      expect(DesignerMailer).to receive(:files_stage_one_day_left).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.files_stage_one_day_left(project)
    end
  end

  describe '#review_files_stage_three_days_left' do
    it 'delivers review_files_stage_three_days_left to ClientMailer' do
      expect(ClientMailer).to receive(:review_files_stage_three_days_left).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.review_files_stage_three_days_left(project)
    end
  end
end

# frozen_string_literal: true

DESIGNER_PROJECT_STATES = Project.aasm.states.map(&:name).map(&:to_s)

DESIGNER_CAN_ACCEPT_PROJECT_NDA_STATES = [
  Project::STATE_FINALIST_STAGE,
  Project::STATE_DESIGN_STAGE
].map(&:to_s)

DESIGNER_CANNOT_ACCEPT_PROJECT_NDA_STATES = (
  DESIGNER_PROJECT_STATES - DESIGNER_CAN_ACCEPT_PROJECT_NDA_STATES
).map(&:to_s)

DESIGNER_ALLOWED_PROJECT_STATES = [
  Project::STATE_DESIGN_STAGE,
  Project::STATE_FINALIST_STAGE,
  Project::STATE_FILES_STAGE,
  Project::STATE_REVIEW_FILES,
  Project::STATE_COMPLETED,
  Project::STATE_ERROR
].map(&:to_s)

DESIGNER_NOT_ALLOWED_PROJECT_STATES = (
  DESIGNER_PROJECT_STATES - DESIGNER_ALLOWED_PROJECT_STATES
).map(&:to_s)

DESIGNER_ALLOWED_UPDATE_PROJECT_STATES = [
  Project::STATE_DESIGN_STAGE
].map(&:to_s)

DESIGNER_NOT_ALLOWED_UPDATE_PROJECT_STATES = (
  DESIGNER_PROJECT_STATES - DESIGNER_ALLOWED_UPDATE_PROJECT_STATES
).map(&:to_s)

DESIGNER_NOT_ALLOWED_RESERVE_SPOT_PROJECT_STATES = (
  DESIGNER_PROJECT_STATES - [Project::STATE_DESIGN_STAGE.to_s]
).map(&:to_s)

RSpec.describe Ability do
  context 'designer' do
    let(:designer) { create(:designer) }

    subject { Ability.new(designer.user) }

    context 'nda price' do
      it { is_expected.not_to be_able_to :read,    NdaPrice }
      it { is_expected.not_to be_able_to :create,  NdaPrice }
      it { is_expected.not_to be_able_to :update,  NdaPrice }
      it { is_expected.not_to be_able_to :destroy, NdaPrice }
    end
    context 'testimonial' do
      it { is_expected.not_to be_able_to :read,    Testimonial }
      it { is_expected.not_to be_able_to :create,  Testimonial }
      it { is_expected.not_to be_able_to :update,  Testimonial }
      it { is_expected.not_to be_able_to :destroy, Testimonial }
    end

    context 'vat rate' do
      it { is_expected.to be_able_to :read, VatRate }

      it { is_expected.not_to be_able_to :create,  VatRate }
      it { is_expected.not_to be_able_to :update,  VatRate }
      it { is_expected.not_to be_able_to :destroy, VatRate }

      it 'can read vat rates' do
        vat_rates = create_list(:vat_rate, 2)

        expect(VatRate.accessible_by(subject, :read)).to match_array(vat_rates)
      end
    end

    context 'faq group' do
      it { is_expected.to be_able_to :read, FaqGroup }

      it { is_expected.not_to be_able_to :create,  FaqGroup }
      it { is_expected.not_to be_able_to :update,  FaqGroup }
      it { is_expected.not_to be_able_to :destroy, FaqGroup }
    end

    context 'faq item' do
      it { is_expected.to be_able_to :read, FaqItem }

      it { is_expected.not_to be_able_to :create, FaqItem }
      it { is_expected.not_to be_able_to :update, FaqItem }
      it { is_expected.not_to be_able_to :destroy, FaqItem }
    end

    context 'Designer' do
      it { is_expected.to be_able_to :read, designer }

      it { is_expected.not_to be_able_to :create,  designer }
      it { is_expected.not_to be_able_to :update,  designer }
      it { is_expected.not_to be_able_to :destroy, designer }
    end

    context 'project price' do
      it { is_expected.not_to be_able_to :read,    ProjectPrice }
      it { is_expected.not_to be_able_to :create,  ProjectPrice }
      it { is_expected.not_to be_able_to :update,  ProjectPrice }
      it { is_expected.not_to be_able_to :destroy, ProjectPrice }
    end

    context 'payout min amount' do
      it { is_expected.to be_able_to :read, PayoutMinAmount }

      it { is_expected.not_to be_able_to :create,  PayoutMinAmount }
      it { is_expected.not_to be_able_to :update,  PayoutMinAmount }
      it { is_expected.not_to be_able_to :destroy, PayoutMinAmount }
    end

    context 'designer portfolio work file' do
      it { is_expected.to be_able_to :create,  UploadedFile::DesignerPortfolioWork }
      it { is_expected.to be_able_to :destroy, UploadedFile::DesignerPortfolioWork }

      it { is_expected.not_to be_able_to :read,   UploadedFile::DesignerPortfolioWork }
      it { is_expected.not_to be_able_to :update, UploadedFile::DesignerPortfolioWork }
    end

    context 'portfolio work' do
      it { is_expected.to be_able_to :read,   PortfolioWork }
      it { is_expected.to be_able_to :create, PortfolioWork }
      it { is_expected.to be_able_to :skip,   PortfolioWork }

      it { is_expected.not_to be_able_to :destroy, PortfolioWork }
      it { is_expected.not_to be_able_to :update,  PortfolioWork }

      it 'can read portfolio works' do
        allowed_portfolios = create_list(:portfolio_work, 2, designer: designer)

        create_list(:portfolio_work, 2)

        expect(PortfolioWork.accessible_by(subject, :index)).to match_array(allowed_portfolios)
      end
    end

    describe 'payouts' do
      describe 'belongs to designer' do
        let(:payout) { create(:payout, designer: designer) }

        it { is_expected.to be_able_to :read,   payout }
        it { is_expected.to be_able_to :create, payout }

        it { is_expected.not_to be_able_to :update,  payout }
        it { is_expected.not_to be_able_to :destroy, payout }

        it 'can read payouts' do
          allowed_payouts = create_list(:payout, 2, designer: designer)

          create_list(:payout, 2)

          expect(Payout.accessible_by(subject, :read)).to match_array(allowed_payouts)
        end
      end

      describe 'does not belong to designer' do
        let(:payout) { create(:payout) }

        it { is_expected.not_to be_able_to :read,    payout }
        it { is_expected.not_to be_able_to :update,  payout }
        it { is_expected.not_to be_able_to :destroy, payout }
        it { is_expected.not_to be_able_to :create,  payout }
      end
    end

    describe 'earnings' do
      describe 'belongs to designer' do
        let(:earning) { create(:earning, designer: designer) }

        it { is_expected.to be_able_to :read,        earning }
        it { is_expected.not_to be_able_to :update,  earning }
        it { is_expected.not_to be_able_to :destroy, earning }
        it { is_expected.not_to be_able_to :create,  earning }

        it 'can read earnings' do
          allowed_earnings = create_list(:earning, 2, designer: designer)

          create_list(:earning, 2)

          expect(Earning.accessible_by(subject, :read)).to match_array(allowed_earnings)
        end
      end

      describe 'does not belong to designer' do
        let(:earning) { create(:earning) }

        it { is_expected.not_to be_able_to :read,    earning }
        it { is_expected.not_to be_able_to :update,  earning }
        it { is_expected.not_to be_able_to :destroy, earning }
        it { is_expected.not_to be_able_to :create,  earning }
      end
    end

    context 'review' do
      it { is_expected.not_to be_able_to :read,    Review }
      it { is_expected.not_to be_able_to :create,  Review }
      it { is_expected.not_to be_able_to :update,  Review }
      it { is_expected.not_to be_able_to :destroy, Review }
    end

    describe 'spot' do
      context 'belongs to designer' do
        context 'project state is :design_stage' do
          let(:project) { create(:project, state: Project::STATE_DESIGN_STAGE) }
          let(:spot)    { create(:spot, designer: designer, project: project) }

          it { is_expected.to     be_able_to :read,    spot }
          it { is_expected.to     be_able_to :create,  spot }
          it { is_expected.not_to be_able_to :update,  spot }
          it { is_expected.not_to be_able_to :destroy, spot }

          it 'can read spots' do
            allowed_spots = create_list(:spot, 2, designer: designer, project: project)

            create_list(:spot, 2)

            expect(Spot.accessible_by(subject, :read)).to match_array(allowed_spots)
          end
        end

        DESIGNER_NOT_ALLOWED_RESERVE_SPOT_PROJECT_STATES.each do |state|
          context "project state is :#{state}" do
            let(:project) { create(:project, state: state) }
            let(:spot)    { create(:spot, designer: designer, project: project) }

            it { is_expected.to     be_able_to :read,    spot }
            it { is_expected.not_to be_able_to :create,  spot }
            it { is_expected.not_to be_able_to :update,  spot }
            it { is_expected.not_to be_able_to :destroy, spot }

            it 'can read spots' do
              allowed_spots = create_list(:spot, 2, designer: designer, project: project)

              create_list(:spot, 2)

              expect(Spot.accessible_by(subject, :read)).to match_array(allowed_spots)
            end
          end
        end
      end

      context 'does not belong to designer' do
        let(:spot) { create(:spot) }

        it { is_expected.not_to be_able_to :read,    spot }
        it { is_expected.not_to be_able_to :create,  spot }
        it { is_expected.not_to be_able_to :update,  spot }
        it { is_expected.not_to be_able_to :destroy, spot }
      end
    end

    context 'design' do
      describe 'belongs to designer' do
        let(:design) { create(:design, designer: designer) }

        it { is_expected.to be_able_to :read,    design }
        it { is_expected.to be_able_to :create,  design }
        it { is_expected.to be_able_to :update,  design }
        it { is_expected.to be_able_to :restore, design }

        it { is_expected.not_to be_able_to :destroy, design }

        it 'can read designs' do
          allowed_designs = create_list(:design, 2, designer: designer)

          create_list(:design, 2)

          expect(Design.accessible_by(subject, :read)).to match_array(allowed_designs)
        end
      end

      describe 'does not belong to designer' do
        let(:design) { create(:design) }

        it { is_expected.not_to be_able_to :read,    design }
        it { is_expected.not_to be_able_to :destroy, design }
        it { is_expected.not_to be_able_to :create,  design }
        it { is_expected.not_to be_able_to :update,  design }
        it { is_expected.not_to be_able_to :restore, design }
      end
    end

    context 'direct conversation message' do
      describe 'design belongs to designer' do
        let(:design)  { create(:design, designer: designer) }
        let(:message) { create(:direct_conversation_message, design: design) }

        it { is_expected.to be_able_to :read, message }

        it { is_expected.not_to be_able_to :create,  message }
        it { is_expected.not_to be_able_to :update,  message }
        it { is_expected.not_to be_able_to :destroy, message }

        context 'can create message' do
          let(:message) { create(:direct_conversation_message, design: design, user: designer.user) }

          it { is_expected.to be_able_to :create, message }
        end

        it 'can read designs' do
          allowed_messages = create_list(:direct_conversation_message, 2, design: design)

          create_list(:design, 2).each do |design|
            create_list(:direct_conversation_message, 2, design: design)
          end

          expect(DirectConversationMessage.accessible_by(subject, :read)).to match_array(allowed_messages)
        end
      end

      describe 'design does not belong to designer' do
        let(:design)  { create(:design) }
        let(:message) { create(:direct_conversation_message, design: design) }

        it { is_expected.not_to be_able_to :read,    message }
        it { is_expected.not_to be_able_to :destroy, message }
        it { is_expected.not_to be_able_to :create,  message }
        it { is_expected.not_to be_able_to :update,  message }
      end
    end

    context 'payment' do
      it { is_expected.not_to be_able_to :read,    Payment }
      it { is_expected.not_to be_able_to :destroy, Payment }
      it { is_expected.not_to be_able_to :create,  Payment }
      it { is_expected.not_to be_able_to :update,  Payment }
    end

    context 'brand examples files' do
      it { is_expected.not_to be_able_to :read,    UploadedFile::BrandExample }
      it { is_expected.not_to be_able_to :destroy, UploadedFile::BrandExample }
      it { is_expected.not_to be_able_to :create,  UploadedFile::BrandExample }
      it { is_expected.not_to be_able_to :update,  UploadedFile::BrandExample }
    end

    context 'technical drawings files' do
      it { is_expected.not_to be_able_to :read,    UploadedFile::TechnicalDrawing }
      it { is_expected.not_to be_able_to :destroy, UploadedFile::TechnicalDrawing }
      it { is_expected.not_to be_able_to :create,  UploadedFile::TechnicalDrawing }
      it { is_expected.not_to be_able_to :update,  UploadedFile::TechnicalDrawing }
    end

    context 'designer nda' do
      describe 'this designer' do
        DESIGNER_CANNOT_ACCEPT_PROJECT_NDA_STATES.each do |state|
          describe "project state: #{state}" do
            let(:project) { create(:project, state: state) }

            let(:designer_nda) do
              build(
                :designer_nda,
                nda: project.nda,
                designer: designer
              )
            end

            it { is_expected.to     be_able_to :read,    designer_nda }
            it { is_expected.not_to be_able_to :create,  designer_nda }
            it { is_expected.not_to be_able_to :update,  designer_nda }
            it { is_expected.not_to be_able_to :destroy, designer_nda }
          end
        end

        DESIGNER_CAN_ACCEPT_PROJECT_NDA_STATES.each do |state|
          describe "project state: #{state}" do
            let(:project) { create(:project, state: state) }

            let(:designer_nda) do
              build(
                :designer_nda,
                nda: project.nda,
                designer: designer
              )
            end

            it { is_expected.to     be_able_to :read,    designer_nda }
            it { is_expected.to     be_able_to :create,  designer_nda }
            it { is_expected.not_to be_able_to :update,  designer_nda }
            it { is_expected.not_to be_able_to :destroy, designer_nda }
          end
        end
      end

      describe 'another designer' do
        let(:designer_nda) { build(:designer_nda) }

        it { is_expected.not_to be_able_to :read,    designer_nda }
        it { is_expected.not_to be_able_to :create,  designer_nda }
        it { is_expected.not_to be_able_to :update,  designer_nda }
        it { is_expected.not_to be_able_to :destroy, designer_nda }
      end
    end

    context 'project' do
      context 'can read project' do
        let(:project) { create(:project, state: DESIGNER_ALLOWED_PROJECT_STATES.sample) }

        it 'with nda' do
          create(:designer_nda, nda: project.nda, designer: designer)
          create(:reserved_spot, project: project, designer: designer)

          expect(subject).to be_able_to(:read, project)
        end
      end

      context 'cannot read project' do
        let(:project) { create(:project, state: DESIGNER_ALLOWED_PROJECT_STATES.sample) }

        it 'without nda' do
          expect(subject).not_to be_able_to(:read, project)
        end

        it 'with client block' do
          create(:designer_client_block, designer: designer, client: project.client)
          create(:designer_nda, nda: project.nda, designer: designer)

          expect(subject).not_to be_able_to(:read, project)
        end
      end

      context 'can update project' do
        let(:project) { create(:project, state: DESIGNER_ALLOWED_UPDATE_PROJECT_STATES.sample) }

        it 'with nda' do
          create(:designer_nda, nda: project.nda, designer: designer)

          expect(subject).to be_able_to(:update, project)
        end
      end

      context 'cannot update project' do
        let(:project) { create(:project, state: DESIGNER_ALLOWED_UPDATE_PROJECT_STATES.sample) }

        it 'without nda' do
          expect(subject).not_to be_able_to(:update, project)
        end

        it 'with client block' do
          create(:designer_nda, nda: project.nda, designer: designer)
          create(:designer_client_block, designer: designer, client: project.client)

          expect(subject).not_to be_able_to(:update, project)
        end

        it 'with denied project type' do
          designer = create(:designer, brand_identity_state: 'pending', packaging_state: 'pending')
          create(:designer_nda, nda: project.nda, designer: designer)
          ability = Ability.new(designer.user)

          expect(ability).not_to be_able_to(:update, project)
        end
      end

      it 'can read projects with accepted project types' do
        allowed_projects = [:logo, :brand_identity].map do |type|
          create(:project_without_nda, project_type: type, state: DESIGNER_ALLOWED_PROJECT_STATES.sample)
        end

        allowed_projects.each do |project|
          create(:free_nda, project: project)
          create(:spot, designer: designer, project: project)
        end

        not_allowed_projects = create(:project_without_nda, project_type: :packaging, state: DESIGNER_ALLOWED_PROJECT_STATES.sample)
        allow(designer).to receive(:approved_project_types).and_return([0, 1])

        expect(Project.accessible_by(subject, :search)).to match_array(allowed_projects)
        expect(Project.accessible_by(subject, :index)).to match_array(allowed_projects)

        expect(Project.accessible_by(subject, :search)).not_to match_array(not_allowed_projects)
        expect(Project.accessible_by(subject, :index)).not_to match_array(not_allowed_projects)
      end

      it 'can read projects with allowed states' do
        allowed_projects = DESIGNER_ALLOWED_PROJECT_STATES.map { |state| create(:project_without_nda, state: state) }

        allowed_projects.each do |project|
          create(:free_nda, project: project)
          create(:spot, designer: designer, project: project)
        end

        not_allowed_projects = DESIGNER_NOT_ALLOWED_PROJECT_STATES.map { |state| create(:project_without_nda, state: state) }

        expect(Project.accessible_by(subject, :search)).to match_array(allowed_projects)
        expect(Project.accessible_by(subject, :index)).to match_array(allowed_projects)

        expect(Project.accessible_by(subject, :search)).not_to match_array(not_allowed_projects)
        expect(Project.accessible_by(subject, :index)).not_to match_array(not_allowed_projects)
      end

      DESIGNER_ALLOWED_PROJECT_STATES.each do |state|
        describe "project with state: :#{state}" do
          let(:project) { create(:project, state: state) }

          before do
            create(:designer_nda, designer: designer, nda: project.nda)
            create(:reserved_spot, designer: designer, project: project)
          end

          it { is_expected.to be_able_to(:read, project) }
        end
      end

      DESIGNER_NOT_ALLOWED_PROJECT_STATES.each do |state|
        describe "project with state: :#{state}" do
          let(:project) { create(:project, state: state) }

          before { create(:designer_nda, designer: designer, nda: project.nda) }

          it { is_expected.not_to be_able_to(:read, project) }
        end
      end

      it 'can update allowed projects with allowed states' do
        allowed_projects = DESIGNER_ALLOWED_UPDATE_PROJECT_STATES.map { |state| create(:project, state: state) }
        allowed_projects.each { |project| create(:designer_nda, designer: designer, nda: project.nda) }
        not_allowed_projects = DESIGNER_NOT_ALLOWED_UPDATE_PROJECT_STATES.map { |state| create(:project, state: state) }

        allowed_projects.each do |project|
          expect(subject).to be_able_to(:update, project)
        end

        not_allowed_projects.each do |project|
          expect(subject).not_to be_able_to(:update, project)
        end
      end
    end

    context 'project state is review files' do
      let(:project) { create(:project, state: Project::STATE_REVIEW_FILES) }

      context 'designer is winner' do
        before(:each) { create(:winner_design, project: project, designer: designer) }

        context 'designer os the owner of source files' do
          let(:source_file) { create(:project_source_file, designer: designer, project: project) }

          it { is_expected.to be_able_to(:read,    source_file) }
          it { is_expected.to be_able_to(:destroy, source_file) }
        end

        context 'designer is not owner of source files' do
          let(:source_file) { create(:project_source_file, project: project) }

          it { is_expected.not_to be_able_to(:read,    source_file) }
          it { is_expected.not_to be_able_to(:destroy, source_file) }
        end
      end

      context 'designer is not winner' do
        let(:source_file) { create(:project_source_file, designer: designer, project: project) }

        it { is_expected.not_to be_able_to(:read,    source_file) }
        it { is_expected.not_to be_able_to(:destroy, source_file) }
      end
    end

    context 'project state is not review_files' do
      it 'cannot delete project source files' do
        project = create(:project)
        project_source_file = create(:project_source_file, designer: designer, project: project)

        expect(subject).not_to be_able_to(:destroy, project_source_file)
      end

      it 'cannot read project source files' do
        project_source_file = create(:project_source_file, designer: designer)

        expect(subject).not_to be_able_to(:read, project_source_file)
      end
    end
  end
end

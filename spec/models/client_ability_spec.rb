# frozen_string_literal: true

require 'rails_helper'

CLIENT_PROJECT_STATES = Project.aasm.states.map(&:name).map(&:to_s)

CLIENT_BEFORE_PAYMENT_PROJECT_STATES = [
  Project::STATE_DRAFT,
  Project::STATE_WAITING_FOR_STYLE_DETAILS,
  Project::STATE_WAITING_FOR_FINISH_DETAILS,
  Project::STATE_WAITING_FOR_AUDIENCE_DETAILS,
  Project::STATE_WAITING_FOR_DETAILS,
  Project::STATE_WAITING_FOR_CHECKOUT
].map(&:to_s)

CLIENT_NOT_BEFORE_PAYMENT_PROJECT_STATES = (
  CLIENT_PROJECT_STATES - CLIENT_BEFORE_PAYMENT_PROJECT_STATES
).map(&:to_s)

CLIENT_ALLOWED_UPDATE_PROJECT_STATES = [
  Project::STATE_WAITING_FOR_STYLE_DETAILS,
  Project::STATE_WAITING_FOR_AUDIENCE_DETAILS,
  Project::STATE_WAITING_FOR_FINISH_DETAILS,
  Project::STATE_WAITING_FOR_DETAILS,
  Project::STATE_WAITING_FOR_CHECKOUT,
  Project::STATE_WAITING_FOR_PAYMENT,
  Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
  Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS,
  Project::STATE_REVIEW_FILES
].map(&:to_s)

CLIENT_NOT_ALLOWED_UPDATE_PROJECT_STATES = (
  CLIENT_PROJECT_STATES - CLIENT_ALLOWED_UPDATE_PROJECT_STATES
).map(&:to_s)

CLIENT_ALLOWED_DESTROY_PROJECT_STATES = [
  Project::STATE_WAITING_FOR_STYLE_DETAILS,
  Project::STATE_WAITING_FOR_AUDIENCE_DETAILS,
  Project::STATE_WAITING_FOR_FINISH_DETAILS
].map(&:to_s)

CLIENT_NOT_ALLOWED_DESTROY_PROJECT_STATES = (
  CLIENT_PROJECT_STATES - CLIENT_ALLOWED_DESTROY_PROJECT_STATES
).map(&:to_s)

RSpec.describe Ability do
  describe 'client' do
    let(:client) { create(:client) }

    subject { Ability.new(client.user) }

    context 'nda price' do
      it { is_expected.to be_able_to :read, NdaPrice }

      it { is_expected.not_to be_able_to :create,  NdaPrice }
      it { is_expected.not_to be_able_to :update,  NdaPrice }
      it { is_expected.not_to be_able_to :destroy, NdaPrice }
    end

    context 'testimonial' do
      it { is_expected.to be_able_to :read, Testimonial }

      it { is_expected.not_to be_able_to :create,  Testimonial }
      it { is_expected.not_to be_able_to :update,  Testimonial }
      it { is_expected.not_to be_able_to :destroy, Testimonial }
    end

    context 'payout min amount' do
      it { is_expected.not_to be_able_to :create,  PayoutMinAmount }
      it { is_expected.not_to be_able_to :read,    PayoutMinAmount }
      it { is_expected.not_to be_able_to :update,  PayoutMinAmount }
      it { is_expected.not_to be_able_to :destroy, PayoutMinAmount }
    end

    context 'vat rate' do
      it { is_expected.to be_able_to :read, VatRate }

      it { is_expected.not_to be_able_to :create,  VatRate }
      it { is_expected.not_to be_able_to :update,  VatRate }
      it { is_expected.not_to be_able_to :destroy, VatRate }
    end

    context 'faq group' do
      it { is_expected.to be_able_to :read, FaqGroup }

      it { is_expected.not_to be_able_to :create,  FaqGroup }
      it { is_expected.not_to be_able_to :update,  FaqGroup }
      it { is_expected.not_to be_able_to :destroy, FaqGroup }
    end

    context 'faq item' do
      it { is_expected.to be_able_to :read, FaqItem }

      it { is_expected.not_to be_able_to :create,  FaqItem }
      it { is_expected.not_to be_able_to :update,  FaqItem }
      it { is_expected.not_to be_able_to :destroy, FaqItem }
    end

    context 'Designer' do
      it { is_expected.not_to be_able_to :read,    Designer }
      it { is_expected.not_to be_able_to :create,  Designer }
      it { is_expected.not_to be_able_to :update,  Designer }
      it { is_expected.not_to be_able_to :destroy, Designer }
    end

    context 'project price' do
      it { is_expected.to be_able_to :read, ProjectPrice }

      it { is_expected.not_to be_able_to :create,  ProjectPrice }
      it { is_expected.not_to be_able_to :update,  ProjectPrice }
      it { is_expected.not_to be_able_to :destroy, ProjectPrice }
    end

    context 'brand example' do
      it { is_expected.to be_able_to :read, UploadedFile::BrandExample }

      it { is_expected.not_to be_able_to :create,  UploadedFile::BrandExample }
      it { is_expected.not_to be_able_to :update,  UploadedFile::BrandExample }
      it { is_expected.not_to be_able_to :destroy, UploadedFile::BrandExample }
    end

    context 'technical drawings' do
      it { is_expected.to be_able_to :create, UploadedFile::TechnicalDrawing }

      it { is_expected.not_to be_able_to :read,    UploadedFile::TechnicalDrawing }
      it { is_expected.not_to be_able_to :update,  UploadedFile::TechnicalDrawing }
      it { is_expected.not_to be_able_to :destroy, UploadedFile::TechnicalDrawing }
    end

    context 'designer portfolio work' do
      it { is_expected.not_to be_able_to :create,  UploadedFile::DesignerPortfolioWork }
      it { is_expected.not_to be_able_to :destroy, UploadedFile::DesignerPortfolioWork }
      it { is_expected.not_to be_able_to :read,    UploadedFile::DesignerPortfolioWork }
      it { is_expected.not_to be_able_to :update,  UploadedFile::DesignerPortfolioWork }
    end

    context 'portfolio work' do
      it { is_expected.not_to be_able_to :create,  PortfolioWork }
      it { is_expected.not_to be_able_to :destroy, PortfolioWork }
      it { is_expected.not_to be_able_to :read,    PortfolioWork }
      it { is_expected.not_to be_able_to :update,  PortfolioWork }
    end

    context 'payments' do
      let(:payment) { create(:payment, project: project) }

      context 'belongs to client' do
        let(:project) { create(:project, client: client) }

        it { is_expected.to be_able_to :read,   payment }
        it { is_expected.to be_able_to :create, payment }

        it { is_expected.not_to be_able_to :update,  payment }
        it { is_expected.not_to be_able_to :destroy, payment }
      end

      context 'does not belong to client' do
        let(:project) { create(:project) }

        it { is_expected.not_to be_able_to :read,    payment }
        it { is_expected.not_to be_able_to :create,  payment }
        it { is_expected.not_to be_able_to :update,  payment }
        it { is_expected.not_to be_able_to :destroy, payment }
      end
    end

    context 'nda' do
      it { is_expected.not_to be_able_to :read,    Nda }
      it { is_expected.not_to be_able_to :create,  Nda }
      it { is_expected.not_to be_able_to :update,  Nda }
      it { is_expected.not_to be_able_to :destroy, Nda }
    end

    context 'designer nda' do
      it { is_expected.not_to be_able_to :read,    DesignerNda }
      it { is_expected.not_to be_able_to :create,  DesignerNda }
      it { is_expected.not_to be_able_to :update,  DesignerNda }
      it { is_expected.not_to be_able_to :destroy, DesignerNda }
    end

    context 'project' do
      context 'can read own project' do
        let(:project) { create(:project, client: client) }

        it { is_expected.to be_able_to :read,    project }
        it { is_expected.to be_able_to :search,  project }
        it { is_expected.to be_able_to :destroy, project }
        it { is_expected.to be_able_to :update,  project }
        it { is_expected.to be_able_to :create,  project }
      end

      it 'can read own projects' do
        allowed_projects = create_list(:project, 2, client: client)
        not_allowed_projects = create_list(:project, 2)

        expect(Project.accessible_by(subject, :search)).to match_array(allowed_projects)
        expect(Project.accessible_by(subject, :read)).to match_array(allowed_projects)

        expect(Project.accessible_by(subject, :search)).not_to match_array(not_allowed_projects)
        expect(Project.accessible_by(subject, :read)).not_to match_array(not_allowed_projects)
      end

      it 'can update own projects with allowed states' do
        allowed_projects = CLIENT_ALLOWED_UPDATE_PROJECT_STATES
                           .map { |state| create(:project, state: state, client: client) }
        not_allowed_projects = CLIENT_NOT_ALLOWED_UPDATE_PROJECT_STATES
                               .map { |state| create(:project, state: state, client: client) }

        expect(Project.accessible_by(subject, :update)).to match_array(allowed_projects)
        expect(Project.accessible_by(subject, :update)).not_to match_array(not_allowed_projects)
      end

      it 'can destroy own projects with allowed states' do
        allowed_projects = CLIENT_ALLOWED_DESTROY_PROJECT_STATES
                           .map { |state| create(:project, state: state, client: client) }
        not_allowed_projects = CLIENT_NOT_ALLOWED_DESTROY_PROJECT_STATES
                               .map { |state| create(:project, state: state, client: client) }

        expect(Project.accessible_by(subject, :destroy)).to match_array(allowed_projects)
        expect(Project.accessible_by(subject, :destroy)).not_to match_array(not_allowed_projects)
      end

      context 'cannot read project of another client' do
        let(:project) { create(:project) }

        it { is_expected.not_to be_able_to(:read,    project) }
        it { is_expected.not_to be_able_to(:search,  project) }
        it { is_expected.not_to be_able_to :update,  project }
        it { is_expected.not_to be_able_to :create,  project }
        it { is_expected.not_to be_able_to :destroy, project }
      end
    end

    context 'eliminated design' do
      let(:project) { create(:project, client: client) }
      let(:design)  { create(:eliminated_design, project: project) }

      it { is_expected.not_to be_able_to(:read,          design) }
      it { is_expected.not_to be_able_to(:block,         design) }
      it { is_expected.not_to be_able_to(:update,        design) }
      it { is_expected.not_to be_able_to(:restore,       design) }
      it { is_expected.not_to be_able_to(:eliminate,     design) }
      it { is_expected.not_to be_able_to(:make_finalist, design) }
    end

    context 'uploaded design' do
      let(:project) { create(:project, client: client) }
      let(:design)  { create(:design, project: project) }

      it { is_expected.to be_able_to(:read,          design) }
      it { is_expected.to be_able_to(:block,         design) }
      it { is_expected.to be_able_to(:update,        design) }
      it { is_expected.to be_able_to(:eliminate,     design) }
      it { is_expected.to be_able_to(:make_finalist, design) }

      it { is_expected.not_to be_able_to(:restore, design) }
    end

    context 'review' do
      context 'my project' do
        context 'winner' do
          let(:design) { create(:winner_design) }
          let(:client) { design.project.client }

          let(:review) { build(:review, client: client, design: design) }

          it { is_expected.to     be_able_to :read,    review }
          it { is_expected.to     be_able_to :create,  review }
          it { is_expected.not_to be_able_to :update,  review }
          it { is_expected.not_to be_able_to :destroy, review }
        end

        [
          Spot::STATE_FINALIST,
          Spot::STATE_ELIMINATED,
          Spot::STATE_DESIGN_UPLOADED
        ].each do |state|
          context state do
            let(:spot)   { create(:spot, state: state) }

            let(:design) do
              build(:design, spot: spot).tap do |design|
                design.save(validate: false)
              end
            end

            let(:client) { design.project.client }

            let(:review) { build(:review, client: client, design: design) }

            it { is_expected.to     be_able_to :read,    review }
            it { is_expected.not_to be_able_to :create,  review }
            it { is_expected.not_to be_able_to :update,  review }
            it { is_expected.not_to be_able_to :destroy, review }
          end
        end
      end

      context 'another project' do
        [
          Spot::STATE_WINNER,
          Spot::STATE_FINALIST,
          Spot::STATE_ELIMINATED,
          Spot::STATE_DESIGN_UPLOADED
        ].each do |state|
          context state do
            let(:spot)   { create(:spot, state: state) }

            let(:design) do
              build(:design, spot: spot).tap do |design|
                design.save(validate: false)
              end
            end

            let(:review) { build(:review, client: client, design: design) }

            it { is_expected.to     be_able_to :read,    review }
            it { is_expected.not_to be_able_to :create,  review }
            it { is_expected.not_to be_able_to :update,  review }
            it { is_expected.not_to be_able_to :destroy, review }
          end
        end
      end
    end

    context 'project associations' do
      context 'public project states' do
        CLIENT_BEFORE_PAYMENT_PROJECT_STATES.each do |state|
          context state do
            let(:project) { create(:project, state: state, client: client) }

            context 'project existing logo' do
              let(:project_existing_logo) { create(:project_existing_logo, project: project) }

              it { is_expected.to be_able_to :create,  project_existing_logo }
              it { is_expected.to be_able_to :destroy, project_existing_logo }

              it { is_expected.not_to be_able_to :read,   project_existing_logo }
              it { is_expected.not_to be_able_to :update, project_existing_logo }
            end

            context 'project competitor' do
              let(:project_competitor) { create(:project_competitor, project: project) }

              it { is_expected.to be_able_to :create,  project_competitor }
              it { is_expected.to be_able_to :destroy, project_competitor }

              it { is_expected.not_to be_able_to :read,    project_competitor }
              it { is_expected.not_to be_able_to :update,  project_competitor }
            end

            context 'project inspiration' do
              let(:project_inspiration) { create(:project_inspiration, project: project) }

              it { is_expected.to be_able_to :create,  project_inspiration }
              it { is_expected.to be_able_to :destroy, project_inspiration }

              it { is_expected.not_to be_able_to :read,    project_inspiration }
              it { is_expected.not_to be_able_to :update,  project_inspiration }
            end

            context 'project additional document' do
              let(:project_additional_document) { create(:project_additional_document, project: project) }

              it { is_expected.to be_able_to :create,  project_additional_document }
              it { is_expected.to be_able_to :destroy, project_additional_document }

              it { is_expected.not_to be_able_to :read,    project_additional_document }
              it { is_expected.not_to be_able_to :update,  project_additional_document }
            end
          end
        end
      end

      context 'non public project states' do
        CLIENT_NOT_BEFORE_PAYMENT_PROJECT_STATES.each do |state|
          context state do
            let(:project) { create(:project, state: state, client: client) }

            context 'project inspiration' do
              let(:project_inspiration) { create(:project_inspiration, project: project) }

              it { is_expected.not_to be_able_to :read,    project_inspiration }
              it { is_expected.not_to be_able_to :create,  project_inspiration }
              it { is_expected.not_to be_able_to :update,  project_inspiration }
              it { is_expected.not_to be_able_to :destroy, project_inspiration }
            end

            context 'project competitor' do
              let(:project_competitor) { create(:project_competitor, project: project) }

              it { is_expected.not_to be_able_to :read,    project_competitor }
              it { is_expected.not_to be_able_to :create,  project_competitor }
              it { is_expected.not_to be_able_to :update,  project_competitor }
              it { is_expected.not_to be_able_to :destroy, project_competitor }
            end

            context 'project existing logo' do
              let(:project_existing_logo) { create(:project_existing_logo, project: project) }

              it { is_expected.not_to be_able_to :read,    project_existing_logo }
              it { is_expected.not_to be_able_to :create,  project_existing_logo }
              it { is_expected.not_to be_able_to :update,  project_existing_logo }
              it { is_expected.not_to be_able_to :destroy, project_existing_logo }
            end

            context 'project additional document' do
              let(:project_additional_document) { create(:project_additional_document, project: project) }

              it { is_expected.not_to be_able_to :read,    project_additional_document }
              it { is_expected.not_to be_able_to :create,  project_additional_document }
              it { is_expected.not_to be_able_to :update,  project_additional_document }
              it { is_expected.not_to be_able_to :destroy, project_additional_document }
            end
          end
        end
      end

      context 'project of another client' do
        CLIENT_BEFORE_PAYMENT_PROJECT_STATES.each do |state|
          context state do
            let(:project) { create(:project, state: state) }

            context 'project inspiration' do
              let(:project_inspiration) { create(:project_inspiration, project: project) }

              it { is_expected.not_to be_able_to :read,    project_inspiration }
              it { is_expected.not_to be_able_to :create,  project_inspiration }
              it { is_expected.not_to be_able_to :update,  project_inspiration }
              it { is_expected.not_to be_able_to :destroy, project_inspiration }
            end

            context 'project competitor' do
              let(:project_competitor) { create(:project_competitor, project: project) }

              it { is_expected.not_to be_able_to :read,    project_competitor }
              it { is_expected.not_to be_able_to :create,  project_competitor }
              it { is_expected.not_to be_able_to :update,  project_competitor }
              it { is_expected.not_to be_able_to :destroy, project_competitor }
            end

            context 'project existing logo' do
              let(:project_existing_logo) { create(:project_existing_logo, project: project) }

              it { is_expected.not_to be_able_to :read,    project_existing_logo }
              it { is_expected.not_to be_able_to :create,  project_existing_logo }
              it { is_expected.not_to be_able_to :update,  project_existing_logo }
              it { is_expected.not_to be_able_to :destroy, project_existing_logo }
            end

            context 'project additional document' do
              let(:project_additional_document) { create(:project_additional_document, project: project) }

              it { is_expected.not_to be_able_to :read,    project_additional_document }
              it { is_expected.not_to be_able_to :create,  project_additional_document }
              it { is_expected.not_to be_able_to :update,  project_additional_document }
              it { is_expected.not_to be_able_to :destroy, project_additional_document }
            end
          end
        end
      end
    end
  end
end

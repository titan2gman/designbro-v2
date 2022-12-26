# frozen_string_literal: true

require 'rails_helper'

GUEST_PROJECT_STATES = Project.aasm.states.map(&:name).map(&:to_s)
GUEST_PUBLIC_PROJECT_STATES = [
  Project::STATE_DRAFT,
  Project::STATE_WAITING_FOR_STYLE_DETAILS,
  Project::STATE_WAITING_FOR_FINISH_DETAILS,
  Project::STATE_WAITING_FOR_AUDIENCE_DETAILS
].map(&:to_s)
GUEST_NOT_PUBLIC_PROJECT_STATES = (
  GUEST_PROJECT_STATES - GUEST_PUBLIC_PROJECT_STATES
).map(&:to_s)

RSpec.describe Ability do
  context 'guest' do
    subject { Ability.new(nil) }

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

    context 'brand examples' do
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

    context 'review' do
      it { is_expected.not_to be_able_to :read,    Review }
      it { is_expected.not_to be_able_to :create,  Review }
      it { is_expected.not_to be_able_to :update,  Review }
      it { is_expected.not_to be_able_to :destroy, Review }
    end

    context 'payment' do
      it { is_expected.not_to be_able_to :read,    Payment }
      it { is_expected.not_to be_able_to :destroy, Payment }
      it { is_expected.not_to be_able_to :create,  Payment }
      it { is_expected.not_to be_able_to :update,  Payment }
    end

    context 'project source file' do
      it { is_expected.not_to be_able_to :read,    ProjectSourceFile }
      it { is_expected.not_to be_able_to :destroy, ProjectSourceFile }
      it { is_expected.not_to be_able_to :create,  ProjectSourceFile }
      it { is_expected.not_to be_able_to :update,  ProjectSourceFile }
    end

    context 'direct conversation messages' do
      it { is_expected.not_to be_able_to :read,    DirectConversationMessage }
      it { is_expected.not_to be_able_to :destroy, DirectConversationMessage }
      it { is_expected.not_to be_able_to :create,  DirectConversationMessage }
      it { is_expected.not_to be_able_to :update,  DirectConversationMessage }
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

    context 'without project-id cookie' do
      GUEST_NOT_PUBLIC_PROJECT_STATES.each do |state|
        context state do
          it { is_expected.not_to be_able_to :create, build(:project, state: state, client: nil) }
        end
      end

      context 'draft project' do
        GUEST_PUBLIC_PROJECT_STATES.each do |state|
          context state do
            let(:project) { create(:project, state: state, client: nil) }

            it { is_expected.to be_able_to :create, build(:project, state: state, client: nil) }

            it { is_expected.not_to be_able_to :read,    project }
            it { is_expected.not_to be_able_to :update,  project }
            it { is_expected.not_to be_able_to :search,  project }
            it { is_expected.not_to be_able_to :destroy, project }

            context 'project existing logo' do
              let(:project_existing_logo) { create(:project_existing_logo, project: project) }

              it { is_expected.not_to be_able_to :read,    project_existing_logo }
              it { is_expected.not_to be_able_to :create,  project_existing_logo }
              it { is_expected.not_to be_able_to :update,  project_existing_logo }
              it { is_expected.not_to be_able_to :destroy, project_existing_logo }
            end

            context 'project competitor' do
              let(:project_competitor) { create(:project_competitor, project: project) }

              it { is_expected.not_to be_able_to :read,    project_competitor }
              it { is_expected.not_to be_able_to :create,  project_competitor }
              it { is_expected.not_to be_able_to :update,  project_competitor }
              it { is_expected.not_to be_able_to :destroy, project_competitor }
            end

            context 'project inspiration' do
              let(:project_inspiration) { create(:project_inspiration, project: project) }

              it { is_expected.not_to be_able_to :read,    project_inspiration }
              it { is_expected.not_to be_able_to :create,  project_inspiration }
              it { is_expected.not_to be_able_to :update,  project_inspiration }
              it { is_expected.not_to be_able_to :destroy, project_inspiration }
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

      context 'non draft project' do
        GUEST_PUBLIC_PROJECT_STATES.each do |state|
          context state do
            let(:project) { create(:project, state: state, client: nil) }

            it { is_expected.not_to be_able_to :read,    project }
            it { is_expected.not_to be_able_to :update,  project }
            it { is_expected.not_to be_able_to :search,  project }
            it { is_expected.not_to be_able_to :destroy, project }

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

    context 'with project-id cookie' do
      GUEST_PUBLIC_PROJECT_STATES.each do |state|
        context "#{state} project" do
          let(:project) { create(:project, state: state, client: nil) }

          context 'with such id' do
            subject { Ability.new(nil, project.id) }

            it { is_expected.to be_able_to :read,    project }
            it { is_expected.to be_able_to :update,  project }
            it { is_expected.to be_able_to :destroy, project }

            it { is_expected.not_to be_able_to :search, project }

            context 'project competitor' do
              let(:project_competitor) { create(:project_competitor, project: project) }

              it { is_expected.to be_able_to :create,  project_competitor }
              it { is_expected.to be_able_to :destroy, project_competitor }

              it { is_expected.not_to be_able_to :read,   project_competitor }
              it { is_expected.not_to be_able_to :update, project_competitor }
            end

            context 'project inspiration' do
              let(:project_inspiration) { create(:project_inspiration, project: project) }

              it { is_expected.to be_able_to :create,  project_inspiration }
              it { is_expected.to be_able_to :destroy, project_inspiration }

              it { is_expected.not_to be_able_to :read, project_inspiration }
              it { is_expected.not_to be_able_to :update, project_inspiration }
            end

            context 'project existing logo' do
              let(:project_existing_logo) { create(:project_existing_logo, project: project) }

              it { is_expected.to be_able_to :create,  project_existing_logo }
              it { is_expected.to be_able_to :destroy, project_existing_logo }

              it { is_expected.not_to be_able_to :read, project_existing_logo }
              it { is_expected.not_to be_able_to :update, project_existing_logo }
            end

            context 'project additional document' do
              let(:project_additional_document) { create(:project_additional_document, project: project) }

              it { is_expected.to be_able_to :create,  project_additional_document }
              it { is_expected.to be_able_to :destroy, project_additional_document }

              it { is_expected.not_to be_able_to :read,   project_additional_document }
              it { is_expected.not_to be_able_to :update, project_additional_document }
            end
          end

          context 'with another id' do
            subject { Ability.new(nil, 'abc') }

            it { is_expected.not_to be_able_to :read,    project }
            it { is_expected.not_to be_able_to :update,  project }
            it { is_expected.not_to be_able_to :search,  project }
            it { is_expected.not_to be_able_to :destroy, project }

            context 'project existing logo' do
              let(:project_existing_logo) { create(:project_existing_logo, project: project) }

              it { is_expected.not_to be_able_to :read,    project_existing_logo }
              it { is_expected.not_to be_able_to :update,  project_existing_logo }
              it { is_expected.not_to be_able_to :create,  project_existing_logo }
              it { is_expected.not_to be_able_to :destroy, project_existing_logo }
            end

            context 'project inspiration' do
              let(:project_inspiration) { create(:project_inspiration, project: project) }

              it { is_expected.not_to be_able_to :read,    project_inspiration }
              it { is_expected.not_to be_able_to :update,  project_inspiration }
              it { is_expected.not_to be_able_to :create,  project_inspiration }
              it { is_expected.not_to be_able_to :destroy, project_inspiration }
            end

            context 'project competitor' do
              let(:project_competitor) { create(:project_competitor, project: project) }

              it { is_expected.not_to be_able_to :read,    project_competitor }
              it { is_expected.not_to be_able_to :update,  project_competitor }
              it { is_expected.not_to be_able_to :create,  project_competitor }
              it { is_expected.not_to be_able_to :destroy, project_competitor }
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

      context 'non draft project' do
        let(:project) { create(:project, state: Project::STATE_DESIGN_STAGE, client: nil) }

        context 'with such id' do
          subject { Ability.new(nil, project.id) }

          it { is_expected.not_to be_able_to :read,    project }
          it { is_expected.not_to be_able_to :update,  project }
          it { is_expected.not_to be_able_to :destroy, project }
          it { is_expected.not_to be_able_to :search,  project }

          context 'project existing logo' do
            let(:project_existing_logo) { create(:project_existing_logo, project: project) }

            it { is_expected.not_to be_able_to :read,    project_existing_logo }
            it { is_expected.not_to be_able_to :update,  project_existing_logo }
            it { is_expected.not_to be_able_to :create,  project_existing_logo }
            it { is_expected.not_to be_able_to :destroy, project_existing_logo }
          end

          context 'project inspiration' do
            let(:project_inspiration) { create(:project_inspiration, project: project) }

            it { is_expected.not_to be_able_to :read,    project_inspiration }
            it { is_expected.not_to be_able_to :update,  project_inspiration }
            it { is_expected.not_to be_able_to :create,  project_inspiration }
            it { is_expected.not_to be_able_to :destroy, project_inspiration }
          end

          context 'project competitor' do
            let(:project_competitor) { create(:project_competitor, project: project) }

            it { is_expected.not_to be_able_to :read,    project_competitor }
            it { is_expected.not_to be_able_to :update,  project_competitor }
            it { is_expected.not_to be_able_to :create,  project_competitor }
            it { is_expected.not_to be_able_to :destroy, project_competitor }
          end

          context 'project additional document' do
            let(:project_additional_document) { create(:project_additional_document, project: project) }

            it { is_expected.not_to be_able_to :read,    project_additional_document }
            it { is_expected.not_to be_able_to :create,  project_additional_document }
            it { is_expected.not_to be_able_to :update,  project_additional_document }
            it { is_expected.not_to be_able_to :destroy, project_additional_document }
          end
        end

        context 'with another id' do
          subject { Ability.new(nil, 'abc') }

          it { is_expected.not_to be_able_to :read,    project }
          it { is_expected.not_to be_able_to :update,  project }
          it { is_expected.not_to be_able_to :destroy, project }
          it { is_expected.not_to be_able_to :search,  project }

          context 'project existing logo' do
            let(:project_existing_logo) { create(:project_existing_logo, project: project) }

            it { is_expected.not_to be_able_to :read,    project_existing_logo }
            it { is_expected.not_to be_able_to :update,  project_existing_logo }
            it { is_expected.not_to be_able_to :create,  project_existing_logo }
            it { is_expected.not_to be_able_to :destroy, project_existing_logo }
          end

          context 'project inspiration' do
            let(:project_inspiration) { create(:project_inspiration, project: project) }

            it { is_expected.not_to be_able_to :read,    project_inspiration }
            it { is_expected.not_to be_able_to :update,  project_inspiration }
            it { is_expected.not_to be_able_to :create,  project_inspiration }
            it { is_expected.not_to be_able_to :destroy, project_inspiration }
          end

          context 'project competitor' do
            let(:project_competitor) { create(:project_competitor, project: project) }

            it { is_expected.not_to be_able_to :read,    project_competitor }
            it { is_expected.not_to be_able_to :update,  project_competitor }
            it { is_expected.not_to be_able_to :create,  project_competitor }
            it { is_expected.not_to be_able_to :destroy, project_competitor }
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

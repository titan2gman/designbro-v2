# frozen_string_literal: true

RSpec.describe DesignerPortfolioDisapprover do
  let(:designer) { create(:designer) }

  before do
    Spot::CAN_BE_DELETED_BY_ADMIN_STATES.each do |state|
      [:logo, :brand_identity, :packaging].each do |project_type|
        project = create(:"#{project_type}_project")

        create(:spot,
               state: state,
               project: project,
               designer: designer)
      end
    end
  end

  before do
    expect(DisapprovePortfolioJob).to receive(:set).with(wait: 5.minutes).and_return(
      double('job').tap { |job| expect(job).to receive(:perform_later) }
    )
  end

  describe DesignerPortfolioDisapprover::BrandIdentity do
    it '.call' do
      DesignerPortfolioDisapprover::BrandIdentity.call(designer)

      active_projects_types = designer.active_projects.pluck(:project_type)
      expect(active_projects_types.uniq).to match_array(['packaging'])
      expect(designer).to be_brand_identity_disapproved
    end
  end

  describe DesignerPortfolioDisapprover::Packaging do
    it '.call' do
      DesignerPortfolioDisapprover::Packaging.call(designer)

      active_projects_types = designer.active_projects.pluck(:project_type)
      expect(active_projects_types.uniq).to match_array(['logo', 'brand_identity'])
      expect(designer).to be_packaging_disapproved
    end
  end
end

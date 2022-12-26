# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DesignerExperienceForm do
  describe '#save' do
    context 'with disapproved states' do
      let(:designer) do
        create(
          :designer,
          experience_brand: 'junior_brand_experience',
          experience_packaging: 'junior_packaging_experience',
          experience_english: 'acceptable_english',
          brand_identity_state: 'disapproved',
          packaging_state: 'disapproved'
        )
      end

      it 'updates all fields' do
        pws = create_list(:designer_portfolio_work, 8)

        form = DesignerExperienceForm.new(
          id: designer.id,
          experience_brand: 'middle_brand_experience',
          experience_packaging: 'middle_packaging_experience',
          experience_english: 'good_english',
          portfolio_works: [
            {
              index: 0,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[0].id
            },
            {
              index: 1,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[1].id
            },
            {
              index: 2,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[2].id
            },
            {
              index: 3,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[3].id
            },
            {
              index: 0,
              work_type: 'packaging',
              description: 'des',
              id: pws[4].id
            },
            {
              index: 1,
              work_type: 'packaging',
              description: 'des',
              id: pws[5].id
            },
            {
              index: 2,
              work_type: 'packaging',
              description: 'des',
              id: pws[6].id
            },
            {
              index: 3,
              work_type: 'packaging',
              description: 'des',
              id: pws[7].id
            }
          ]
        )

        expect(designer.portfolio_works.count).to eq(0)

        form.save

        designer.reload

        expect(designer.experience_brand).to eq('middle_brand_experience')
        expect(designer.experience_packaging).to eq('middle_packaging_experience')
        expect(designer.experience_english).to eq('good_english')
        expect(designer.portfolio_works.count).to eq(8)
        expect(designer.brand_identity_pending?).to be true
        expect(designer.packaging_pending?).to be true
      end

      it 'updates only bi state' do
        pws = create_list(:designer_portfolio_work, 8)

        form = DesignerExperienceForm.new(
          id: designer.id,
          experience_brand: 'middle_brand_experience',
          experience_packaging: 'middle_packaging_experience',
          experience_english: 'good_english',
          portfolio_works: [
            {
              index: 0,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[0].id
            },
            {
              index: 1,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[1].id
            },
            {
              index: 2,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[2].id
            },
            {
              index: 3,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[3].id
            }
          ]
        )

        expect(designer.portfolio_works.count).to eq(0)

        form.save

        designer.reload

        expect(designer.experience_brand).to eq('middle_brand_experience')
        expect(designer.experience_packaging).to eq('middle_packaging_experience')
        expect(designer.experience_english).to eq('good_english')
        expect(designer.portfolio_works.count).to eq(4)
        expect(designer.brand_identity_pending?).to be true
        expect(designer.packaging_pending?).to be false
      end

      it 'updates only packaging state' do
        pws = create_list(:designer_portfolio_work, 8)

        form = DesignerExperienceForm.new(
          id: designer.id,
          experience_brand: 'middle_brand_experience',
          experience_packaging: 'middle_packaging_experience',
          experience_english: 'good_english',
          portfolio_works: [
            {
              index: 0,
              work_type: 'packaging',
              description: 'des',
              id: pws[0].id
            },
            {
              index: 1,
              work_type: 'packaging',
              description: 'des',
              id: pws[1].id
            },
            {
              index: 2,
              work_type: 'packaging',
              description: 'des',
              id: pws[2].id
            },
            {
              index: 3,
              work_type: 'packaging',
              description: 'des',
              id: pws[3].id
            }
          ]
        )

        expect(designer.portfolio_works.count).to eq(0)

        form.save

        designer.reload

        expect(designer.experience_brand).to eq('middle_brand_experience')
        expect(designer.experience_packaging).to eq('middle_packaging_experience')
        expect(designer.experience_english).to eq('good_english')
        expect(designer.portfolio_works.count).to eq(4)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be true
      end

      it 'not update states' do
        create_list(:designer_portfolio_work, 8)

        form = DesignerExperienceForm.new(
          id: designer.id,
          experience_brand: 'middle_brand_experience',
          experience_packaging: 'middle_packaging_experience',
          experience_english: 'good_english',
          portfolio_works: []
        )

        expect(designer.portfolio_works.count).to eq(0)

        form.save

        designer.reload

        expect(designer.experience_brand).to eq('middle_brand_experience')
        expect(designer.experience_packaging).to eq('middle_packaging_experience')
        expect(designer.experience_english).to eq('good_english')
        expect(designer.portfolio_works.count).to eq(0)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be false
      end
    end

    context 'with approved states' do
      let(:designer) do
        create(
          :designer,
          experience_brand: 'junior_brand_experience',
          experience_packaging: 'junior_packaging_experience',
          experience_english: 'acceptable_english',
          brand_identity_state: 'approved',
          packaging_state: 'approved'
        )
      end

      it 'updates all fields' do
        pws = create_list(:designer_portfolio_work, 8)

        form = DesignerExperienceForm.new(
          id: designer.id,
          experience_brand: 'middle_brand_experience',
          experience_packaging: 'middle_packaging_experience',
          experience_english: 'good_english',
          portfolio_works: [
            {
              index: 0,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[0].id
            },
            {
              index: 1,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[1].id
            },
            {
              index: 2,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[2].id
            },
            {
              index: 3,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[3].id
            },
            {
              index: 0,
              work_type: 'packaging',
              description: 'des',
              id: pws[4].id
            },
            {
              index: 1,
              work_type: 'packaging',
              description: 'des',
              id: pws[5].id
            },
            {
              index: 2,
              work_type: 'packaging',
              description: 'des',
              id: pws[6].id
            },
            {
              index: 3,
              work_type: 'packaging',
              description: 'des',
              id: pws[7].id
            }
          ]
        )

        expect(designer.portfolio_works.count).to eq(0)

        form.save

        designer.reload

        expect(designer.experience_brand).to eq('middle_brand_experience')
        expect(designer.experience_packaging).to eq('middle_packaging_experience')
        expect(designer.experience_english).to eq('good_english')
        expect(designer.portfolio_works.count).to eq(8)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be false
      end

      it 'updates only bi state' do
        pws = create_list(:designer_portfolio_work, 8)

        form = DesignerExperienceForm.new(
          id: designer.id,
          experience_brand: 'middle_brand_experience',
          experience_packaging: 'middle_packaging_experience',
          experience_english: 'good_english',
          portfolio_works: [
            {
              index: 0,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[0].id
            },
            {
              index: 1,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[1].id
            },
            {
              index: 2,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[2].id
            },
            {
              index: 3,
              work_type: 'brand_identity',
              description: 'des',
              id: pws[3].id
            }
          ]
        )

        expect(designer.portfolio_works.count).to eq(0)

        form.save

        designer.reload

        expect(designer.experience_brand).to eq('middle_brand_experience')
        expect(designer.experience_packaging).to eq('middle_packaging_experience')
        expect(designer.experience_english).to eq('good_english')
        expect(designer.portfolio_works.count).to eq(4)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be false
      end

      it 'updates only packaging state' do
        pws = create_list(:designer_portfolio_work, 8)

        form = DesignerExperienceForm.new(
          id: designer.id,
          experience_brand: 'middle_brand_experience',
          experience_packaging: 'middle_packaging_experience',
          experience_english: 'good_english',
          portfolio_works: [
            {
              index: 0,
              work_type: 'packaging',
              description: 'des',
              id: pws[0].id
            },
            {
              index: 1,
              work_type: 'packaging',
              description: 'des',
              id: pws[1].id
            },
            {
              index: 2,
              work_type: 'packaging',
              description: 'des',
              id: pws[2].id
            },
            {
              index: 3,
              work_type: 'packaging',
              description: 'des',
              id: pws[3].id
            }
          ]
        )

        expect(designer.portfolio_works.count).to eq(0)

        form.save

        designer.reload

        expect(designer.experience_brand).to eq('middle_brand_experience')
        expect(designer.experience_packaging).to eq('middle_packaging_experience')
        expect(designer.experience_english).to eq('good_english')
        expect(designer.portfolio_works.count).to eq(4)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be false
      end

      it 'not update states' do
        create_list(:designer_portfolio_work, 8)

        form = DesignerExperienceForm.new(
          id: designer.id,
          experience_brand: 'middle_brand_experience',
          experience_packaging: 'middle_packaging_experience',
          experience_english: 'good_english',
          portfolio_works: []
        )

        form.save

        designer.reload

        expect(designer.experience_brand).to eq('middle_brand_experience')
        expect(designer.experience_packaging).to eq('middle_packaging_experience')
        expect(designer.experience_english).to eq('good_english')
        expect(designer.portfolio_works.count).to eq(0)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be false
      end
    end
  end
end

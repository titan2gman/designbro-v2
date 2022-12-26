# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PortfolioForm do
  describe '#save' do
    context 'with valid attributes' do
      it 'saves portfolio works' do
        designer = create(:designer)
        uploaded_file = create(:designer_portfolio_work)
        work_attrs = attributes_for(:portfolio_work)
        form = PortfolioForm.new(
          id: designer.id,
          portfolio_works: [work_attrs.merge(id: uploaded_file.id.to_s)]
        )

        expect { form.save }.to change { designer.portfolio_works.count }.by(1)
      end
    end

    context 'with draft states' do
      let(:designer) do
        create(
          :designer,
          brand_identity_state: 'draft',
          packaging_state: 'draft'
        )
      end

      it 'updates all fields' do
        pws = create_list(:designer_portfolio_work, 8)

        form = PortfolioForm.new(
          id: designer.id,
          portfolio_works: [
            {
              work_type: 'brand_identity',
              description: 'des',
              id: pws[0].id
            },
            {
              work_type: 'brand_identity',
              description: 'des',
              id: pws[1].id
            },
            {
              work_type: 'brand_identity',
              description: 'des',
              id: pws[2].id
            },
            {
              work_type: 'brand_identity',
              description: 'des',
              id: pws[3].id
            },
            {
              work_type: 'packaging',
              description: 'des',
              id: pws[4].id
            },
            {
              work_type: 'packaging',
              description: 'des',
              id: pws[5].id
            },
            {
              work_type: 'packaging',
              description: 'des',
              id: pws[6].id
            },
            {
              work_type: 'packaging',
              description: 'des',
              id: pws[7].id
            }
          ]
        )

        expect(designer.portfolio_works.count).to eq(0)

        form.save

        designer.reload

        expect(designer.portfolio_works.count).to eq(8)
        expect(designer.brand_identity_pending?).to be true
        expect(designer.packaging_pending?).to be true
      end

      it 'updates only bi state' do
        pws = create_list(:designer_portfolio_work, 8)

        form = PortfolioForm.new(
          id: designer.id,
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

        expect(designer.portfolio_works.count).to eq(4)
        expect(designer.brand_identity_pending?).to be true
        expect(designer.packaging_pending?).to be false
      end

      it 'updates only packaging state' do
        pws = create_list(:designer_portfolio_work, 8)

        form = PortfolioForm.new(
          id: designer.id,
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

        expect(designer.portfolio_works.count).to eq(4)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be true
      end

      it 'not update states' do
        create_list(:designer_portfolio_work, 8)

        form = PortfolioForm.new(
          id: designer.id,
          portfolio_works: []
        )

        expect(designer.portfolio_works.count).to eq(0)

        form.save

        designer.reload

        expect(designer.portfolio_works.count).to eq(0)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be false
      end
    end

    context 'with approved states' do
      let(:designer) do
        create(
          :designer,
          brand_identity_state: 'approved',
          packaging_state: 'approved'
        )
      end

      it 'updates all fields' do
        pws = create_list(:designer_portfolio_work, 8)

        form = PortfolioForm.new(
          id: designer.id,
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

        expect(designer.portfolio_works.count).to eq(8)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be false
      end

      it 'updates only bi state' do
        pws = create_list(:designer_portfolio_work, 8)

        form = PortfolioForm.new(
          id: designer.id,
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

        expect(designer.portfolio_works.count).to eq(4)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be false
      end

      it 'updates only packaging state' do
        pws = create_list(:designer_portfolio_work, 8)

        form = PortfolioForm.new(
          id: designer.id,
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

        expect(designer.portfolio_works.count).to eq(4)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be false
      end

      it 'not update states' do
        create_list(:designer_portfolio_work, 8)

        form = PortfolioForm.new(
          id: designer.id,
          portfolio_works: []
        )

        form.save

        designer.reload

        expect(designer.portfolio_works.count).to eq(0)
        expect(designer.brand_identity_pending?).to be false
        expect(designer.packaging_pending?).to be false
      end
    end
  end
end

# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Receipts', js: true do
  describe 'client' do
    scenario 'logo' do
      client = create(:client)

      project = create(:logo_project, state: Project::STATE_DESIGN_STAGE, client: client)
      payment = create(:payment, project: project)

      create(:eu_billing_address, project: project)
      create(:united_kingdom_vat_rate)
      create(:logo_project_price)

      headers = client.user.create_new_auth_token
      visit "/receipts/#{project.id}?#{headers.to_query}"

      expect(page).to have_content(I18n.t('invoice_receipt.table.project', project_type_name: 'Logo Design'))
      expect(page).to have_content(payment.payment_id)
    end

    scenario 'packaging' do
      client = create(:client)

      project = create(:packaging_project, state: Project::STATE_DESIGN_STAGE, client: client)
      payment = create(:payment, project: project)

      create(:eu_billing_address, project: project)
      create(:united_kingdom_vat_rate)
      create(:packaging_project_price)

      headers = client.user.create_new_auth_token
      visit "/receipts/#{project.id}?#{headers.to_query}"

      expect(page).to have_content(I18n.t('invoice_receipt.table.project', project_type_name: 'Packaging Design'))
      expect(page).to have_content(payment.payment_id)
    end

    scenario 'brand identity' do
      client = create(:client)

      project = create(:brand_identity_project, state: Project::STATE_DESIGN_STAGE, client: client)
      payment = create(:payment, project: project)

      create(:eu_billing_address, project: project)
      create(:brand_identity_project_price)
      create(:united_kingdom_vat_rate)

      headers = client.user.create_new_auth_token
      visit "/receipts/#{project.id}?#{headers.to_query}"

      expect(page).to have_content(I18n.t('invoice_receipt.table.project', project_type_name: 'Identity Pack'))
      expect(page).to have_content(payment.payment_id)
    end

    scenario 'logo upgraded to brand identity' do
      client = create(:client)

      project = create(:brand_identity_project,
                       state: Project::STATE_DESIGN_STAGE,
                       client: client,
                       upgrade_package: true)
      payment = create(:payment, project: project)

      create(:eu_billing_address, project: project)
      create(:logo_project_price)
      create(:brand_identity_project_price)
      create(:united_kingdom_vat_rate)

      headers = client.user.create_new_auth_token
      visit "/receipts/#{project.id}?#{headers.to_query}"

      expect(page).to have_content(I18n.t('invoice_receipt.table.upgrade_pack'))
      expect(page).to have_content(I18n.t('invoice_receipt.table.project', project_type_name: 'Logo Design'))
      expect(page).to have_content(payment.payment_id)
    end
  end
end

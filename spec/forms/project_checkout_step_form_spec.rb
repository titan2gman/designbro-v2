# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectCheckoutStepForm do
  let(:stripe_helper) { StripeMock.create_test_helper }

  before do
    StripeMock.start
    stripe_token_object = double
    allow(stripe_token_object).to receive(:email)
    allow(Stripe::Token).to receive(:retrieve).and_return(stripe_token_object)
    allow(Stripe::Charge).to receive(:create)
    allow(InvoiceJob).to receive(:perform_later)
  end

  after { StripeMock.stop }

  describe 'Payment Type: Bank Transfer' do
    scenario 'Project Type: Brand Identity' do
      create(:brand_identity_project_price)
      billing_address_attributes = attributes_for(:billing_address)
      project = create(:brand_identity_project, state: Project::STATE_WAITING_FOR_CHECKOUT)

      form = ProjectCheckoutStepForm.new(
        billing_address_attributes.merge(
          discount_code: create(:dollar_discount, value: 200).code,
          payment_type: 'bank_transfer',
          upgrade_project_state: true,
          business_customer: false,
          id: project.id
        )
      )

      expect(form).to be_valid
      expect(form.save).to be_truthy

      project.reload

      expect(project.state).to eq Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS.to_s

      payment = project.payment
      expect(payment).not_to be_nil
      expect(payment).to be_persisted
      expect(payment.payment_type).to eq 'bank_transfer'
    end

    scenario 'Project Type: Logo Design' do
      project_price = create(:logo_project_price)
      billing_address_attributes = attributes_for(:billing_address)
      project = create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT)

      form = ProjectCheckoutStepForm.new(
        billing_address_attributes.merge(
          payment_type: 'bank_transfer',
          business_customer: false,
          upgrade_project_state: true,
          id: project.id
        )
      )

      expect(form).to be_valid
      expect(form.save).to be_truthy

      project.reload

      expect(project.state).to eq Project::STATE_WAITING_FOR_PAYMENT.to_s
      expect(project.type_price).to eq project_price.price

      payment = project.payment
      expect(payment).not_to be_nil
      expect(payment).to be_persisted
      expect(payment.payment_type).to eq 'bank_transfer'
    end

    scenario 'Project type: Logo Design (with upgrading to brand identity)' do
      project_price = create(:brand_identity_project_price, price: 900)
      billing_address_attributes = attributes_for(:billing_address)
      project = create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT, upgrade_package: true)

      form = ProjectCheckoutStepForm.new(
        billing_address_attributes.merge(
          payment_type: 'bank_transfer',
          business_customer: false,
          upgrade_project_state: true,
          country_code: 'GB',
          id: project.id
        )
      )

      vat_rate = VatRate.create(
        country_name: 'England',
        country_code: 'GB',
        percent: 10
      )

      expect(form).to be_valid
      expect(form.save).to be_truthy

      project = form.project
      standard_nda_price = create(:standard_nda).price.to_f
      discount = project.discount_amount.to_f
      vat_price = (project_price.price + standard_nda_price - discount) * (vat_rate.percent / 100.0)

      expect(project.price).to eq(project_price.price + standard_nda_price + vat_price - project.discount_amount.to_f)
      expect(project.project_type).to eq('brand_identity')
      expect(project.type_price).to eq project_price.price
    end

    scenario 'Project Type: Packaging Design' do
      project_price = create(:packaging_project_price)
      billing_address_attributes = attributes_for(:billing_address)
      project = create(:packaging_project, state: Project::STATE_WAITING_FOR_CHECKOUT)

      form = ProjectCheckoutStepForm.new(
        billing_address_attributes.merge(
          payment_type: 'bank_transfer',
          business_customer: false,
          upgrade_project_state: true,
          id: project.id
        )
      )

      expect(form).to be_valid
      expect(form.save).to be_truthy

      project.reload

      expect(project.state).to eq Project::STATE_WAITING_FOR_PAYMENT.to_s
      expect(project.type_price).to eq project_price.price

      payment = project.payment
      expect(payment).not_to be_nil
      expect(payment).to be_persisted
      expect(payment.payment_type).to eq 'bank_transfer'
    end
  end

  describe 'Copy checkout data to client settings' do
    scenario 'client settings are nil' do
      client = Client.new(
        user: create(:user)
      )

      client.save(validate: false)

      create(:packaging_project_price)
      billing_address_attributes = attributes_for(:billing_address)
      project = create(:packaging_project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

      form = ProjectCheckoutStepForm.new(
        billing_address_attributes.merge(
          payment_type: 'bank_transfer',
          business_customer: false,
          upgrade_project_state: true,
          id: project.id
        )
      )

      form.save
      client.reload

      properties = {
        first_name: :first_name,
        last_name: :last_name,

        address1: :address1,
        address2: :address2,

        company_name: :company,
        state_name: :state,
        phone: :phone,
        city: :city,
        zip: :zip,
        vat: :vat
      }

      properties.each do |client_property_name, billing_address_property_name|
        expected_value = billing_address_attributes[
          billing_address_property_name
        ]

        actual_value = client.public_send(client_property_name)
        expect(actual_value).to eq(expected_value)
      end

      expect(client.country_code).not_to be_empty
    end

    scenario 'client settings are not empty' do
      client = create(:client)
      create(:packaging_project_price)
      billing_address_attributes = attributes_for(:billing_address)
      project = create(:packaging_project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

      form = ProjectCheckoutStepForm.new(
        billing_address_attributes.merge(
          payment_type: 'bank_transfer',
          business_customer: false,
          upgrade_project_state: true,
          id: project.id
        )
      )

      form.save
      client.reload

      properties = {
        first_name: :first_name,
        last_name: :last_name,

        address1: :address1,

        company_name: :company,
        state_name: :state,
        phone: :phone,
        city: :city,
        zip: :zip
      }

      properties.each do |client_property_name, billing_address_property_name|
        expected_value = billing_address_attributes[
          billing_address_property_name
        ]

        actual_value = client.public_send(client_property_name)
        expect(actual_value).not_to eq(expected_value)
      end

      [:address2, :vat].each do |property_name|
        expected_value = billing_address_attributes[property_name]
        actual_value = client.public_send(property_name)
        expect(actual_value).to eq(expected_value)
      end

      expect(client.country_code).not_to be_empty
    end
  end

  describe '#save' do
    context 'with valid attributes' do
      it 'successfully updates project in DB (enable business customer)' do
        create(:logo_project_price)

        billing_address_attributes = attributes_for(:billing_address)
        project = create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT, business_customer: false)

        form = ProjectCheckoutStepForm.new(
          billing_address_attributes.merge(
            payment_type: 'credit_card',
            stripe_token: stripe_helper.generate_card_token,
            business_customer: true,
            upgrade_project_state: true,
            id: project.id
          )
        )

        expect(form).to be_valid
        expect(form.save).to be_truthy

        project = Project.last

        expect(project.state).to eq Project::STATE_DESIGN_STAGE.to_s
        expect(project.billing_address).not_to be_nil
        expect(project.business_customer).to be_truthy

        billing_address = project.billing_address

        billing_address_attributes.each do |field_name, expected_value|
          expect(billing_address.public_send(field_name)).to eq(expected_value)
        end

        payment = project.payment
        expect(payment).not_to be_nil
        expect(payment.payment_type).to eq 'credit_card'
      end

      it 'successfully updates project in DB (enable business customer) but does not change status and not pay' do
        create(:logo_project_price)

        billing_address_attributes = attributes_for(:billing_address)
        project = create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT, business_customer: false)

        form = ProjectCheckoutStepForm.new(
          billing_address_attributes.merge(
            payment_type: 'credit_card',
            stripe_token: 'abcdef0123456789',
            business_customer: true,
            upgrade_project_state: false,
            id: project.id
          )
        )

        expect(form).to be_valid
        expect(form.save).to be_truthy

        project = Project.last

        expect(project.state).to eq Project::STATE_WAITING_FOR_CHECKOUT.to_s
        expect(project.billing_address).not_to be_nil
        expect(project.business_customer).to be_truthy

        billing_address = project.billing_address

        billing_address_attributes.each do |field_name, expected_value|
          expect(billing_address.public_send(field_name)).to eq(expected_value)
        end
      end

      it 'successfully updates project in DB (disable business customer)' do
        create(:logo_project_price)

        billing_address_attributes = attributes_for(:billing_address)
        project = create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT, business_customer: true)

        form = ProjectCheckoutStepForm.new(
          billing_address_attributes.merge(
            payment_type: 'credit_card',
            stripe_token: stripe_helper.generate_card_token,
            business_customer: false,
            upgrade_project_state: true,
            id: project.id
          )
        )

        expect(form).to be_valid
        expect(form.save).to be_truthy

        project = Project.last

        expect(project.state).to eq Project::STATE_DESIGN_STAGE.to_s
        expect(project.billing_address).not_to be_nil
        expect(project.business_customer).to be_falsey

        billing_address = project.billing_address

        billing_address_attributes.except(:vat, :company).each do |field_name, expected_value|
          expect(billing_address.public_send(field_name)).to eq(expected_value)
        end

        [:vat, :company].each { |field_name| expect(billing_address.public_send(field_name)).to be_nil }

        payment = project.payment
        expect(payment).not_to be_nil
        expect(payment.payment_type).to eq 'credit_card'
      end

      it 'successfully updates project in DB (disable business customer) but does not change state and not pay' do
        create(:logo_project_price)

        billing_address_attributes = attributes_for(:billing_address)
        project = create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT, business_customer: true)

        form = ProjectCheckoutStepForm.new(
          billing_address_attributes.merge(
            payment_type: 'credit_card',
            stripe_token: 'abcdef0123456789',
            business_customer: false,
            upgrade_project_state: false,
            id: project.id
          )
        )

        expect(form).to be_valid
        expect(form.save).to be_truthy

        project = Project.last

        expect(project.state).to eq Project::STATE_WAITING_FOR_CHECKOUT.to_s
        expect(project.billing_address).not_to be_nil
        expect(project.business_customer).to be_falsey

        billing_address = project.billing_address

        billing_address_attributes.each do |field_name, expected_value|
          expect(billing_address.public_send(field_name)).to eq(expected_value)
        end
      end

      it "updates project in DB and sets project state #{Project::STATE_WAITING_FOR_STATIONERY_DETAILS}\
          if it is identity pack" do
        create(:brand_identity_project_price)

        billing_address_attributes = attributes_for(:billing_address)
        project = create(:brand_identity_project, state: Project::STATE_WAITING_FOR_CHECKOUT)

        form = ProjectCheckoutStepForm.new(
          billing_address_attributes.merge(
            payment_type: 'credit_card',
            stripe_token: stripe_helper.generate_card_token,
            business_customer: false,
            upgrade_project_state: true,
            id: project.id
          )
        )

        expect(form).to be_valid
        expect(form.save).to be_truthy

        project = Project.last
        billing_address = project.billing_address

        expect(project.state).to eq Project::STATE_WAITING_FOR_STATIONERY_DETAILS.to_s

        billing_address_attributes.except(:vat, :company).each do |field_name, expected_value|
          expect(billing_address.public_send(field_name)).to eq(expected_value)
        end

        [:vat, :company].each { |field_name| expect(billing_address.public_send(field_name)).to be_nil }
      end

      it "updates project in DB and but doesn't change project state if it isn't continue project" do
        create(:brand_identity_project_price)

        billing_address_attributes = attributes_for(:billing_address)
        project = create(:brand_identity_project, state: Project::STATE_WAITING_FOR_CHECKOUT)

        form = ProjectCheckoutStepForm.new(
          billing_address_attributes.merge(
            payment_type: 'credit_card',
            stripe_token: 'abcdef0123456789',
            business_customer: false,
            upgrade_project_state: false,
            id: project.id
          )
        )

        expect(form).to be_valid
        expect(form.save).to be_truthy

        project = Project.last

        expect(project.state).to eq Project::STATE_WAITING_FOR_CHECKOUT.to_s
      end

      describe 'payment_type: nil' do
        it 'does not modify project state' do
          create(:brand_identity_project_price)

          billing_address_attributes = attributes_for(:billing_address)
          project = create(:brand_identity_project, state: Project::STATE_WAITING_FOR_CHECKOUT)

          form = ProjectCheckoutStepForm.new(
            billing_address_attributes.merge(
              business_customer: false,
              upgrade_project_state: true,
              id: project.id
            )
          )

          expect(form).to be_valid
          expect(form.save).to be_truthy

          project.reload

          expect(project.payment).to be_nil
          expect(project.state).to eq Project::STATE_WAITING_FOR_CHECKOUT.to_s
        end
      end
    end

    context 'validations', type: :model do
      subject { ProjectCheckoutStepForm.new(upgrade_project_state: true) }

      it { is_expected.to validate_presence_of(:id) }
      it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:country_code) }

      it { is_expected.not_to validate_presence_of(:stripe_token) }
      it { is_expected.not_to validate_presence_of(:company) }

      describe 'checks presence of company name if it`s business customer' do
        subject { ProjectCheckoutStepForm.new(business_customer: true, upgrade_project_state: true) }
        it { is_expected.to validate_presence_of(:company) }
      end

      describe 'does not check presence of company name if it`s not business customer' do
        subject { ProjectCheckoutStepForm.new(business_customer: false, upgrade_project_state: true) }
        it { is_expected.not_to validate_presence_of(:company) }
      end

      describe 'does not check presence of company name if it`s not continue project' do
        subject { ProjectCheckoutStepForm.new(business_customer: true, upgrade_project_state: false) }
        it { is_expected.not_to validate_presence_of(:company) }
      end

      it 'should be invalid if country is unreal' do
        form = ProjectCheckoutStepForm.new(country: 'AA', country_code: 'A', upgrade_project_state: true)
        expect(form).to be_invalid

        errors = form.errors.messages[:country_code]
        expect(errors).to include('is invalid')
      end

      it 'should be valid if country code is real' do
        form = ProjectCheckoutStepForm.new(country: 'Ukraine', country_code: 'UA', upgrade_project_state: true)
        expect(form.errors.messages[:country_code]).to be_empty
      end

      describe 'credit card payment' do
        before { subject.payment_type = 'credit_card' }
        it { is_expected.to validate_presence_of(:stripe_token) }
      end
    end
  end
end

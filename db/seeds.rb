# frozen_string_literal: true

if Rails.env.development?
  AdminUser.first_or_create(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password'
  )

  client_user = User.first_or_create(
    email: 'client@example.com',
    confirmed_at: DateTime.now,

    password: 'password',
    password_confirmation: 'password'
  )

  unless Client.first
    client = FactoryBot.create(:client, user: client_user)

    product = Product.find_by!(key: 'logo')

    brand = FactoryBot.create(:brand, company: client.company)
    brand_dna = FactoryBot.create(:brand_dna, brand: brand)

    project = FactoryBot.create(:project, state: Project::STATE_DESIGN_STAGE, product: product, brand_dna: brand_dna)
    FactoryBot.create(:payment, project: project)
    FactoryBot.create(:united_kingdom_vat_rate)
  end

  designer_user = User.where(email: 'designer@example.com').first_or_create(
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: DateTime.now
  )

  unless Designer.first
    FactoryBot.create :designer, user: designer_user
  end

  unless FaqGroup.first
    faq_groups = FactoryBot.create_list :faq_group, 3

    faq_groups.each do |faq_group|
      FactoryBot.create_list :faq_item, 4, faq_group: faq_group
    end
  end

  unless UploadedFile::BrandExample.first
    (1..10).each do |name|
      path = File.join(Rails.root, 'spec', 'factories', 'files', "#{name}.png")
      FactoryBot.create :brand_example, file: Rack::Test::UploadedFile.new(path)
    end
  end

  unless Inspiration.first
    3.times do
      Inspiration.create(
        project: Project.first,
        comment: Faker::Lorem.sentence,
        inspiration_image: FactoryBot.create(:inspiration_image)
      )
    end
  end

  unless Design.first
    FactoryBot.create(:design, designer: Designer.first, project: Project.first)
  end

  FactoryBot.create_list(:testimonial, 5)

  { standard: 35, custom: 98, free: 0 }.each do |type, price|
    unless NdaPrice.find_by(nda_type: type)
      NdaPrice.create(nda_type: type, price: Money.new(price * 100, 'USD'))
    end
  end

  PayoutMinAmount.first_or_create(amount: 25_000)

  %i[summary logo brand_identity packaging].each do |type|
    PortfolioList.find_or_create_by(list_type: type)
  end

  {
    logo: [55, 105, 150, 190, 225, 255, 280],
    'brand-identity': [55, 105, 150, 190, 225, 255, 280],
    packaging: [100, 190, 275, 355, 425, 485, 535]
  }.each do |type, array|
    product = Product.find_by!(key: type)

    unless AdditionalDesignPrice.find_by(product: product)
      [array, [4, 5, 6, 7, 8, 9, 10]].transpose.each do |amount, quantity|
        AdditionalDesignPrice.create(product: product, amount: Money.from_amount(amount), quantity: quantity)
      end
    end
  end

  Project::REMINDER_ACTIVE_STATES.each_with_index do |name, index|
    next if AbandonedCartReminder.exists?(name: name)
    AbandonedCartReminder.create(name: name, step: index + 1, minutes_to_reminder: ((1.day.to_i / 60) * (index + 1)))
  end

  AbandonedCartDiscount.create if AbandonedCartDiscount.count.zero?
end

product = Product.find_by!(key: 'website')

unless AdditionalScreenPrice.find_by(product: product)
  (2..10).each do |quantity|
    AdditionalScreenPrice.create(
      product: product,
      amount: Money.from_amount(150) * (quantity - 1),
      quantity: quantity
    )
  end
end

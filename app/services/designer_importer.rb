# frozen_string_literal: true

class DesignerImporter
  include Callable

  def initialize(file)
    @file = file
  end

  def call
    designer_structs.each do |designer_struct|
      next if User.exists? email: designer_struct.email

      designer = Designer.new(designer_struct.designer_attributes)
      user     = User.new(designer_struct.user_attributes)

      designer.user = user
      designer.save!
    end
  end

  private

  def designer_structs
    SpreadsheetParser.call(@file).map do |data|
      DesignerStruct.new(*data)
    end
  end
end

attributes = [:display_name, :first_name, :last_name, :gender, :country, :birth_year, :experience_brand, :experience_packaging, :experience_english, :email, :logo1, :logo2, :logo3, :logo4, :packaging1, :packaging2, :packaging3, :packaging4, :password]

DesignerStruct = Struct.new(*attributes) do
  def user_attributes
    {
      email: email,
      password: password,
      confirmed_at: Time.zone.now
    }
  end

  def designer_attributes
    portfolio_works_attributes = []

    [logo1, logo2, logo3, logo4].each do |logo|
      uploaded_file = build_uploaded_file(logo)

      next unless uploaded_file

      portfolio_works_attributes << {
        work_type: :brand_identity,
        uploaded_file: uploaded_file,
        description: 'No description.'
      }
    end

    [packaging1, packaging2, packaging3, packaging4].each do |packaging|
      uploaded_file = build_uploaded_file(packaging)

      next unless uploaded_file

      portfolio_works_attributes << {
        work_type: :packaging,
        uploaded_file: uploaded_file,
        description: 'No description.'
      }
    end

    {
      display_name: unique_display_name,

      first_name: first_name,
      last_name: last_name,
      age: age,

      gender: gender.zero? ? 1 : 0,

      country_code: country_code,

      experience_brand: experience_brand,
      experience_english: experience_english,
      experience_packaging: experience_packaging,

      portfolio_uploaded: true,

      packaging_state: 'approved',
      brand_identity_state: 'approved',

      portfolio_works_attributes: portfolio_works_attributes
    }
  end

  private

  def age
    Time.zone.now.year - birth_year
  end

  def country_code
    country_code = ISO3166::Country.find_country_by_name(country)&.alpha2
    raise "No country with name: '#{country}'" unless country_code

    country_code
  end

  def unique_display_name
    "#{first_name}.#{last_name}".downcase
  end

  def build_uploaded_file(remote_file_url)
    return nil if remote_file_url.blank?
    return nil if remote_file_url == 'no'

    # try to build entity of UploadedFile::DesignerPortfolioWork with link from spreadsheet
    uploaded_file = UploadedFile::DesignerPortfolioWork.new(remote_file_url: remote_file_url)

    # if Carrierwave wasn't able to download image then return default file
    uploaded_file.remote_file_url = default_uploaded_file_url unless uploaded_file.valid?

    uploaded_file
  end

  def default_uploaded_file_url
    ENV['MAILER_HOST'] + ActionController::Base.helpers.asset_path('default_portfolio_work_design.png')
  end
end

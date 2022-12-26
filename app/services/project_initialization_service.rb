# frozen_string_literal: true

class ProjectInitializationService
  attr_reader :project

  def initialize(params, client)
    @params = params
    @client = client
    @company = client&.company
  end

  def call!
    find_or_create_brand!

    find_or_create_brand_dna!

    create_project!
  end

  private

  def find_or_create_brand!
    @brand = if @company
               if @params[:is_new_brand]
                 @company.brands.create!(name: @params[:brand_name])
               else
                 @company.brands.find(@params[:brand_id])
               end
             else
               Brand.create!(name: @params[:brand_name])
             end
  end

  def find_or_create_brand_dna!
    @brand_dna = @brand.brand_dnas.first_or_create!
  end

  def create_project!
    @project = @brand_dna.projects.create!(
      product_id: @params[:product_id]
    )
  end
end

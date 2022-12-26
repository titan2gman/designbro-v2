class MigrateProjectsDataToBrandsAndBrandDnas < ActiveRecord::Migration[5.2]
  def up
    Project.find_each do |project|
      client = project.client_id ? Client.find(project.client_id) : nil

      brand = Brand.find_or_create_by!(
        name: project.brand_name,
        slogan: project.slogan,
        additional_text: project.additional_text,
        description: project.company_description,
        background_story: project.background_story,
        where_it_is_used: project.where_it_is_used,
        what_is_special: project.what_is_special,
        company_id: client&.company_id,
        created_at: project.created_at,
        updated_at: project.updated_at
      )

      brand_dna = BrandDna.find_or_create_by!(
        bold_or_refined: project.bold_or_refined,
        detailed_or_clean: project.detailed_or_clean,
        handcrafted_or_minimalist: project.handcrafted_or_minimalist,
        low_income_or_high_income: project.low_income_or_high_income,
        masculine_or_premium: project.masculine_or_premium,
        outmoded_actual: project.outmoded_actual,
        serious_or_playful: project.serious_or_playful,
        stand_out_or_not_from_the_crowd: project.stand_out_or_not_from_the_crowd,
        traditional_or_modern: project.traditional_or_modern,
        value_or_premium: project.value_or_premium,
        youthful_or_mature: project.youthful_or_mature,
        target_country_codes: project.target_country_codes,
        brand_id: brand.id,
        created_at: project.created_at,
        updated_at: project.updated_at
      )

      project.brand_dna_id = brand_dna.id
      project.save!(validate: false)
    end
  end

  def down
  end
end

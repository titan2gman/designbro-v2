class AddHeroImageToDesigner < ActiveRecord::Migration[5.2]
  def change
    add_reference :designers, :hero_image, index: true, foreign_key: { to_table: :featured_images }
  end
end

class AddDiscountToProjects < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :projects, :discount, foreign_key: true
    add_monetize :projects, :discount_amount
  end
end

class AddIndexToPortfolioWorks < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolio_works, :index, :integer, null: false, index: true, default: 0

    Designer.find_each do |d|
      d.portfolio_works.group_by(&:work_type).each do |_, values|
        values.each_with_index do |pw, i|
          pw.update(index: i)
        end
      end
    end
  end
end

class Desinger < ApplicationRecord
  has_many :portfolio_works
end

class PortfolioWork < ApplicationRecord; end

# frozen_string_literal: true

class BrandDna < ApplicationRecord
  belongs_to :brand

  has_many :projects, dependent: :destroy

  has_many :clients, through: :brand
  has_many :ndas, through: :brand
  has_one :active_nda, class_name: 'Nda', through: :brand

  # only for stats on brands page
  has_many :projects_completed, -> { completed }, class_name: 'Project'
  has_many :projects_in_progress, -> { in_progress }, class_name: 'Project'
  has_many :project_source_files, through: :projects
  has_many :unread_designs, through: :projects

  has_many :competitors, through: :brand

  validates :bold_or_refined, inclusion: 0..10
  validates :outmoded_actual, inclusion: 0..10
  validates :value_or_premium, inclusion: 0..10
  validates :detailed_or_clean, inclusion: 0..10
  validates :serious_or_playful, inclusion: 0..10
  validates :youthful_or_mature, inclusion: 0..10
  validates :masculine_or_premium, inclusion: 0..10
  validates :traditional_or_modern, inclusion: 0..10
  validates :low_income_or_high_income, inclusion: 0..10
  validates :handcrafted_or_minimalist, inclusion: 0..10
  validates :stand_out_or_not_from_the_crowd, inclusion: 0..10

  delegate :name, to: :brand, allow_nil: true
end

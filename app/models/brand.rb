# frozen_string_literal: true

class Brand < ApplicationRecord
  belongs_to :company, optional: true

  has_many :brand_dnas, dependent: :destroy
  has_many :ndas, dependent: :destroy
  has_many :competitors, dependent: :destroy
  has_many :inspirations, dependent: :destroy
  has_many :existing_designs, dependent: :destroy

  # TODO: make flexible according to expiration dates
  has_one :active_nda, -> { order('id DESC') }, class_name: 'Nda'

  has_many :projects, through: :brand_dnas

  has_many :clients, through: :company

  # only for stats on brands page
  has_many :projects_completed, through: :brand_dnas
  has_many :projects_in_progress, through: :brand_dnas
  has_many :project_source_files, through: :brand_dnas
  has_many :unread_designs, through: :brand_dnas

  # for admin panel
  accepts_nested_attributes_for :competitors, allow_destroy: true

  delegate :not_free?, to: :active_nda, allow_nil: true, prefix: true

  def has_paid_project
    projects.where(state: Project::DESIGNER_CAN_READ_STATES).any?
  end
end

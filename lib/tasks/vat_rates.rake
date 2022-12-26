# frozen_string_literal: true

VAT_RATES = {
  AT: 20,
  BE: 21,
  HR: 25,
  CZ: 21,
  DK: 25,
  EE: 20,
  FI: 24,
  FR: 20,
  DE: 19,
  GB: 20,
  GR: 23,
  HU: 27,
  IE: 23,
  IT: 22,
  LV: 21,
  LT: 21,
  LU: 15,
  NL: 21,
  NO: 25,
  PL: 23,
  PT: 23,
  RO: 24,
  SI: 22,
  SK: 20,
  ES: 21,
  SE: 25,
  CH: 7.7,
  TR: 18
}.freeze

namespace :vat_rates do
  task load: :environment do
    VAT_RATES.each do |country_code, percent|
      country_name = ISO3166::Country.new(country_code).name

      VatRate.create country_name: country_name,
                     country_code: country_code,
                     percent: percent
    end
  end
end

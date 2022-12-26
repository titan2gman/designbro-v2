# frozen_string_literal: true

ADDITIONAL_SPOTS_SURCHARGE = 0.15
ADDITIONAL_TIME_PRICE_PER_DAY = 15 # USD

LANGUAGES = [{
  code: 'ab',
  name: 'Abkhazian'
},
             {
               code: 'af',
               name: 'Afrikaans'
             },
             {
               code: 'sq',
               name: 'Albanian'
             },
             {
               code: 'ar',
               name: 'Arabic'
             },
             {
               code: 'an',
               name: 'Aragonese'
             },
             {
               code: 'hy',
               name: 'Armenian'
             },
             {
               code: 'av',
               name: 'Avaric'
             },
             {
               code: 'be',
               name: 'Belarusian'
             },
             {
               code: 'bn',
               name: 'Bengali'
             },
             {
               code: 'bs',
               name: 'Bosnian'
             },
             {
               code: 'br',
               name: 'Breton'
             },
             {
               code: 'bg',
               name: 'Bulgarian'
             },
             {
               code: 'my',
               name: 'Burmese'
             },
             {
               code: 'ce',
               name: 'Chechen'
             },
             {
               code: 'zh',
               name: 'Chinese'
             },
             {
               code: 'hr',
               name: 'Croatian'
             },
             {
               code: 'cs',
               name: 'Czech'
             },
             {
               code: 'da',
               name: 'Danish'
             },
             {
               code: 'nl',
               name: 'Dutch'
             },
             {
               code: 'en',
               name: 'English'
             },
             {
               code: 'et',
               name: 'Estonian'
             },
             {
               code: 'fo',
               name: 'Faroese'
             },
             {
               code: 'fi',
               name: 'Finnish'
             },
             {
               code: 'fr',
               name: 'French'
             },
             {
               code: 'ka',
               name: 'Georgian'
             },
             {
               code: 'de',
               name: 'German'
             },
             {
               code: 'el',
               name: 'Greek'
             },
             {
               code: 'he',
               name: 'Hebrew'
             },
             {
               code: 'hi',
               name: 'Hindi'
             },
             {
               code: 'hu',
               name: 'Hungarian'
             },
             {
               code: 'is',
               name: 'Icelandic'
             },
             {
               code: 'id',
               name: 'Indonesian'
             },
             {
               code: 'iu',
               name: 'Inuktitut'
             },
             {
               code: 'ga',
               name: 'Irish'
             },
             {
               code: 'it',
               name: 'Italian'
             },
             {
               code: 'ja',
               name: 'Japanese'
             },
             {
               code: 'jv',
               name: 'Javanese'
             },
             {
               code: 'ko',
               name: 'Korean'
             },
             {
               code: 'lv',
               name: 'Latvian'
             },
             {
               code: 'lt',
               name: 'Lithuanian'
             },
             {
               code: 'mk',
               name: 'Macedonian'
             },
             {
               code: 'mg',
               name: 'Malagasy'
             },
             {
               code: 'ms',
               name: 'Malay'
             },
             {
               code: 'mt',
               name: 'Maltese'
             },
             {
               code: 'mi',
               name: 'Maori'
             },
             {
               code: 'mn',
               name: 'Mongolian'
             },
             {
               code: 'na',
               name: 'Nauru'
             },
             {
               code: 'ne',
               name: 'Nepali'
             },
             {
               code: 'no',
               name: 'Norwegian'
             },
             {
               code: 'oc',
               name: 'Occitan'
             },
             {
               code: 'oj',
               name: 'Ojibwa'
             },
             {
               code: 'fa',
               name: 'Persian'
             },
             {
               code: 'pl',
               name: 'Polish'
             },
             {
               code: 'pt',
               name: 'Portuguese'
             },
             {
               code: 'ro',
               name: 'Romanian'
             },
             {
               code: 'ru',
               name: 'Russian'
             },
             {
               code: 'sm',
               name: 'Samoan'
             },
             {
               code: 'sc',
               name: 'Sardinian'
             },
             {
               code: 'sr',
               name: 'Serbian'
             },
             {
               code: 'sd',
               name: 'Sindhi'
             },
             {
               code: 'sk',
               name: 'Slovak'
             },
             {
               code: 'sl',
               name: 'Slovenian'
             },
             {
               code: 'so',
               name: 'Somali'
             },
             {
               code: 'es',
               name: 'Spanish '
             },
             {
               code: 'su',
               name: 'Sundanese'
             },
             {
               code: 'sw',
               name: 'Swahili'
             },
             {
               code: 'sv',
               name: 'Swedish'
             },
             {
               code: 'tl',
               name: 'Tagalog'
             },
             {
               code: 'th',
               name: 'Thai'
             },
             {
               code: 'tr',
               name: 'Turkish'
             },
             {
               code: 'uk',
               name: 'Ukrainian'
             },
             {
               code: 'ur',
               name: 'Urdu'
             },
             {
               code: 'uz',
               name: 'Uzbek'
             },
             {
               code: 'vi',
               name: 'Vietnamese'
             },
             {
               code: 'zu',
               name: 'Zulu'
             }].freeze

LANGUAGES_HASH = LANGUAGES.map { |l| [l[:code], l[:name]] }.to_h

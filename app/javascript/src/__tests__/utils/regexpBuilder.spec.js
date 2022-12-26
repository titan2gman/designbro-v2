import { buildKeywordsRegexp } from '@utils/regexpsBuilder'

describe('regexpsBuilder', () => {
  describe('buildKeywordsRegexp', () => {
    describe('empty array', () => {
      it('returns null', () => {
        expect(buildKeywordsRegexp([])).toBe(null)
      })
    })

    describe('array with one element', () => {
      it('returns regexp for one word', () => {
        const regexp = buildKeywordsRegexp(['abc'])
        expect(regexp.test(' abc. ')).toBeTruthy()
      })
    })

    describe('array with 2 elements', () => {
      it('returns regexp for 2 words', () => {
        const regexp = buildKeywordsRegexp(['abc', 'def'])
        expect(regexp.test(' abc. def! ')).toBeTruthy()
      })
    })
  })
})

import { splitStringBySpace } from '@utils/stringProcessor'

describe('stringProcessor', () => {
  describe('splitStringBySpace', () => {
    describe('empty string', () => {
      it('returns empty array', () => {
        expect(splitStringBySpace('').length).toBe(0)
      })
    })

    describe('string with one word', () => {
      it('returns array with one element', () => {
        expect(splitStringBySpace('abc')).toContain('abc')
      })
    })

    describe('string with 3 words', () => {
      it('returns array with 3 elements', () => {
        expect(splitStringBySpace('abc def lmn'))
          .toContain('abc', 'def', 'lmn')
      })

      it('returns array with 3 elements ignoring empty string', () => {
        expect(splitStringBySpace('abc  def  lmn'))
          .toContain('abc', 'def', 'lmn')
      })
    })
  })
})

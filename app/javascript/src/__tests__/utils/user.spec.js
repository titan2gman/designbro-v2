import { letterifyName } from '@utils/user'

describe('user', () => {
  describe('letterifyName', () => {
    describe('with empty parts', () => {
      it('returns U', () => {
        const result = letterifyName([])

        expect(result).toBe('U')
      })
    })

    describe('with one part', () => {
      it('returns first letter uppercased', () => {
        const result = letterifyName(['nicolas'])

        expect(result).toBe('N')
      })
    })

    describe('with many parts', () => {
      it('returns first letter uppercased from first two parts', () => {
        const result = letterifyName(['nicolas', 'cage', 'brudinski'])

        expect(result).toBe('NC')
      })
    })
  })
})

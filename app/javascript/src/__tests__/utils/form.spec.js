import { normalizePhone } from '@utils/form'

describe('form', () => {
  describe('normalizePhone', () => {
    describe('with non numeric string', () => {
      it('removes non numeric char', () => {
        const result = normalizePhone('12ab+c')
        expect(result).toBe('12')
      })
    })

    describe('with non numeric string with first plus', () => {
      it('removes non numeric char', () => {
        const result = normalizePhone('+12abc')
        expect(result).toBe('+12')
      })
    })

    describe('with first plus', () => {
      it('returns these numbers', () => {
        const result = normalizePhone('+123')
        expect(result).toBe('+123')
      })

      it('returns first 12 numbers', () => {
        const result = normalizePhone('+1234567890123')
        expect(result).toBe('+123456789012')
      })
    })

    describe('without plus', () => {
      it('returns these numbers', () => {
        const result = normalizePhone('123456')
        expect(result).toBe('123456')
      })

      it('returns first 10 numbers', () => {
        const result = normalizePhone('12345678901')
        expect(result).toBe('1234567890')
      })
    })
  })
})

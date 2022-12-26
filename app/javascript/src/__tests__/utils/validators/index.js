import { required, adult } from '@utils/validators'

describe('validators', () => {
  describe('required', () => {
    describe('with empty value', () => {
      it('returns falsey', () => {
        const value = ''

        const result = required(value)

        expect(result).toBeFalsey
      })
    })

    describe('with space value', () => {
      it('returns falsey', () => {
        const value = '          '

        const result = required(value)

        expect(result).toBeFalsey
      })
    })

    describe('with normal value, ()', () => {
      it('returns truthy', () => {
        const value = 'normal value'

        const result = required(value)

        expect(result).toBeTruthy
      })
    })
  })

  describe('adult', () => {
    describe('with less value', () => {
      it('returns falsey', () => {
        const value = '17'

        const result = adult(value)

        expect(result).toBeFalsey
      })
    })

    describe('with normal value', () => {
      it('returns truthy', () => {
        const value = '18'

        const result = adult(value)

        expect(result).toBeTruthy
      })
    })
  })
})

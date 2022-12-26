import { pastTimeDifference, getTimeDiffInDaysOrHours } from '@utils/dateTime'

describe('dateTime', () => {
  describe('getTimeDiffInDaysOrHours', () => {
    it('returns 0 hours when from > to', () => {
      const from = new Date(2020, 1, 2)
      const to = new Date(2020, 1, 1)

      const result = getTimeDiffInDaysOrHours(to, from)

      expect(result).toBe(pastTimeDifference)
    })

    it('returns hour when about 1 hour', () => {
      const from = new Date(2020, 1, 1, 10)
      const to = new Date(2020, 1, 1, 11)

      const result = getTimeDiffInDaysOrHours(to, from)

      expect(result).toBe('1 hour')
    })

    it('returns hours when less than 1 day', () => {
      const from = new Date(2020, 1, 1, 10)
      const to = new Date(2020, 1, 1, 12)

      const result = getTimeDiffInDaysOrHours(to, from)

      expect(result).toBe('2 hours')
    })

    it('returns day when about 1 day', () => {
      const from = new Date(2020, 1, 1, 10)
      const to = new Date(2020, 1, 2, 11)

      const result = getTimeDiffInDaysOrHours(to, from)

      expect(result).toBe('1 day')
    })

    it('returns days when more than 1 day', () => {
      const from = new Date(2020, 1, 1, 10)
      const to = new Date(2020, 1, 3, 10)

      const result = getTimeDiffInDaysOrHours(to, from)

      expect(result).toBe('2 days')
    })
  })
})

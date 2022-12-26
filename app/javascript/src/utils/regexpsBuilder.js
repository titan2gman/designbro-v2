const buildKeywordsRegexp = (keywords) => keywords.length > 0
  ? new RegExp(`\\b(${keywords.join('|')})\\b`, 'i') : null

export { buildKeywordsRegexp }

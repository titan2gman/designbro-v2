import React from 'react'

export const renderAsParagraphs = (lines) => {
  return lines && lines.split('\n').map((line, i) => {
    return (
      <p key={i} className="multiline">
        {line}
      </p>
    )
  })
}

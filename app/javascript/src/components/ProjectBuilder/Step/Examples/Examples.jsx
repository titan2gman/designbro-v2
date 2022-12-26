import React, { useEffect } from 'react'

import BadExamples from './BadExamplesContainer'
import GoodExamples from './GoodExamplesContainer'
import ExampleChooser from './ExampleChooserContainer'

const Examples = ({ loadBrandExamples }) => {
  useEffect(() => {
    loadBrandExamples()
  }, [])

  return (
    <div className="bfs-content__flex">
      <GoodExamples />
      <ExampleChooser />
      <BadExamples />
    </div>
  )
}

export default Examples

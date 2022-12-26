import React from 'react'
import Input from './InputContainer'

const InputBriefingContainer = (props) => (
  <div className="row">
    <div className="col-md-8">
      <Input {...props} />
    </div>
  </div>
)

export default InputBriefingContainer

import React, { useState, useCallback  } from 'react'

import BrandsListContainer from './BrandsListContainer'
import SearchPanel from './SearchPanel'

import { debounce } from '@utils/debounce'

const ClientBrandsPage = ({ loadBrands }) => {
  const [name, setName] = useState('')

  const debounceCallback = useCallback(
    debounce(params => {
      loadBrands(params)
    }, 300),
    []
  )

  const handleSearchNameChange = ({ target: { value } }) => {
    setName(value)

    debounceCallback({
      name_cont: value
    })
  }

  return (
    <main className="brands-list">
      <div className="header">
        <h1>My Brands</h1>

        <SearchPanel
          onNameChange={handleSearchNameChange}
          name={name}
        />
      </div>

      <BrandsListContainer
        loadBrands={() => loadBrands({ name_cont: name })}
      />
    </main>
  )
}

export default ClientBrandsPage

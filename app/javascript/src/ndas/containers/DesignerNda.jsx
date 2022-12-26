import { connect } from 'react-redux'

import { getNdaById } from '@selectors/ndas'
import { getCompanyById } from '@selectors/companies'
import { getBrandById } from '@selectors/brands'

import DesignerNda from '@ndas/components/DesignerNda'

const mapStateToProps = (state, { designerNda }) => {
  const brand = getBrandById(designerNda.brand)(state)
  const company = getCompanyById(brand.company)(state)
  const nda = getNdaById(designerNda.nda)(state)

  return {
    brand,
    company,
    nda
  }
}

export default connect(mapStateToProps)(DesignerNda)

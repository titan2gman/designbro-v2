import { connect } from 'react-redux'

import PackagingTypeItem from './PackagingTypeItem'

const mapStateToProps = (state, { packagingType }) => ({
  isSelected: state.forms.newProjectPackagingType
    .packagingType === packagingType
})

export default connect(mapStateToProps)(PackagingTypeItem)

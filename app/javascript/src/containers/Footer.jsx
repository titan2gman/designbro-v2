import { connect } from 'react-redux'

import { getMe } from '@reducers/me'

import Footer from '@components/Footer'

const mapStateToProps = (state) => ({
  userType: getMe(state).userType
})

export default connect(mapStateToProps)(Footer)

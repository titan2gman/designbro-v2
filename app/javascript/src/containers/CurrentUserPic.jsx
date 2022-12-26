import { connect } from 'react-redux'
import { getLongName, getMe } from '@reducers/me'
import { letterifyName } from '@utils/user'

import UserPic from '@components/UserPic'

const getName = (me) => letterifyName(getLongName(me))

const mapStateToProps = (state) => ({ name: getName(getMe(state)) })

export default connect(mapStateToProps)(UserPic)

import { connect } from 'react-redux'
import { getLongName, getMe } from '@reducers/me'
import { letterifyName } from '@utils/user'

import UserPicture from '@components/UserPicture'

const getName = (me) => letterifyName(getLongName(me))

const mapStateToProps = (state) => ({ name: getName(getMe(state)) })

export default connect(mapStateToProps)(UserPicture)

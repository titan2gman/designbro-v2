import { connect } from 'react-redux'
import { getLongName, getMe } from '@reducers/me'
import { letterifyName } from '@utils/user'
import ProjectCardUserPic from '@components/ProjectCardUserPic'

const getName = (me) => letterifyName(getLongName(me))

const mapStateToProps = (state, ownProps) => {
  return {
    ...ownProps,
    name: getName(getMe(state))
  }
}

export default connect(mapStateToProps)(ProjectCardUserPic)

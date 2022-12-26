import { connect } from 'react-redux'
import SimpleModal from '@components/SimpleModal'
import { close } from '@actions/simpleModal'

const mapStateToProps = (state) => {
  return state.simpleModal
}

export default connect(mapStateToProps, {
  onClose: close
})(SimpleModal)

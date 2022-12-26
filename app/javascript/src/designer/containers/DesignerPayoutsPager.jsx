import { connect } from 'react-redux'
import { changePage, loadPayouts } from '@actions/payouts'
import Pager from '@components/Pager'

const mapStateToProps = ({ payouts }) => {
  const { pager } = payouts
  return {
    current: pager.currentPage,
    total: pager.totalPages
  }
}

export default connect(mapStateToProps, {
  onClick: (page) => [changePage(page), loadPayouts()]
})(Pager)

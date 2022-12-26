import { connect } from 'react-redux'
import { changePage, loadEarnings } from '@actions/earnings'
import Pager from '@components/Pager'

const mapStateToProps = ({ earnings }) => {
  const { pager } = earnings
  return {
    current: pager.currentPage,
    total: pager.totalPages
  }
}

export default connect(mapStateToProps, {
  onClick: (page) => [changePage(page), loadEarnings()]
})(Pager)

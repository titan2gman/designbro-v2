import { connect } from 'react-redux'

import { changePage, loadPayments } from '@actions/payments'

import Pager from '@components/Pager'

const handlePageChange = (page) => ([
  changePage(page), loadPayments()
])

const mapStateToProps = ({ payments: { pager } }) => ({
  current: pager.currentPage,
  total: pager.totalPages
})

const mapDispatchToProps = {
  onClick: handlePageChange
}

export default connect(mapStateToProps, mapDispatchToProps)(Pager)
